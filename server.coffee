'use strict'

# dependencies
express = require 'express'
body = require 'body-parser'
mongoose = require 'mongoose'
extend = require 'extend'
formy = require 'formidable'
fs = require 'fs'

# connect db
mongoose.connect process.env.MONGO_URI or 'mongodb://localhost:27017/bsound-dev'

# connection events
mongoose.connection.on 'connected', -> console.log 'mongoose connected to mongodb://localhost:27017/bsound-dev successfully'
mongoose.connection.on 'disconnected', -> console.log 'mongoose disconnected'
mongoose.connection.on 'error', (err) -> console.log 'mongoose connection error'; mongoose.connection.close -> throw err
process.on 'SIGINT', -> mongoose.connection.close -> console.log 'mongoose connection disconnected through app termination'; process.exit 0

# models configuring
Product = mongoose.model 'Product', new mongoose.Schema
	name: String
	info: String
	overview: String
	cost: Number
	discount: Number
	yevalue: Number
	currency: type: String, enum: ['US', 'EU', 'RU', 'YE']
	index: Number
	techs: Array
	type: type: String, enum: [
		'loudspeackers'
		'speackers'
		'wirelesssystems'
		'volumecontrolsselectorswallpanels'
		'videocamerainternalip'
		'videocamerastreetip'
		'transformer'
		'streetanalogvideocamera'
		'signalsources'
		'preamplifiers'
		'poweramplifier'
		'passivespeackers'
		'passivemixerpults'
		'passiveloudspeackers'
		'networkvideorecorders'
		'mixersamplifiers'
		'microphones'
		'lowimpedanceamplifier'
		'internalanalogmideocamera'
		'hybridvideorecorders'
		'feedbacksuppressor'
		'equalizers'
		'effectsprocessors'
		'dynamicprocessingdevices'
		'controllersspeackers'
		'analogvideorecorder'
		'amplifier100'
		'activespeackers'
		'activemixerpults'
		'activeloudspeackers'
	]
	description: title: String, short: String, full: String
	pictures: main: String, other: [String]
	related: [type: mongoose.Schema.Types.ObjectId, ref: 'Product']
Report = mongoose.model 'Report', new mongoose.Schema
	title: String
	date: Date
	text: String
	pictures: main: String
Article = mongoose.model 'Article', new mongoose.Schema
	title: String
	date: Date
	text: String
	pictures: main: String
Kit = mongoose.model 'Kit', new mongoose.Schema
	tree: [mongoose.Schema.Types.Mixed]
Category = mongoose.model 'Category', new mongoose.Schema
	tree: [mongoose.Schema.Types.Mixed]

# routes configuring
products =
	find: (req, res) ->
		conditions = {}
		if req.query['name*']? then conditions.name = new RegExp "#{req.query['name*']}", 'i'
		if req.query.ids?
			ids = req.query.ids.split ','
			conditions._id = $in: ids
		Product
			.find conditions
			.populate 'related'
			.exec (err, products) ->
				if err then throw err
				res.json products
	create: (req, res) -> Product.create req.body, (err, product) -> if err then throw err else res.json product
	read: (req, res) ->
		Product
			.findById req.params.id
			.populate 'related'
			.exec (err, product) ->
				res.json product
	update: (req, res) ->
		if req.body._id then delete req.body._id
		Product.findByIdAndUpdate req.params.id, req.body, (err, product) -> if err then throw err else res.json product
	delete: (req, res) -> Product.findByIdAndRemove req.params.id, (err, product) -> if err then throw err else res.send 200
	uploads:
		pictures:
			main:
				upload: (req, res) ->
					form = new formy.IncomingForm()
					form.parse req, (err, fields, files) ->
						if err then throw err
						Product.findById req.params.id, (err, product) ->
							if err then throw err
							product.pictures.main = files.main.name
							product.save (err, product) ->
								if err then throw err
								fs.readFile files.main.path, (err, data) ->
									if err then throw err
									newpath = "#{__dirname}/public/pictures/#{files.main.name}"
									fs.writeFile newpath, data, (writeerr) ->
										if writeerr
											product.pictures.main = null
											product.save (err, product) ->
												if err then throw err
												throw writeerr
										res.json product.pictures.main
				'delete': (req, res) ->
					Product.findById req.params.id, (err, product) ->
						if err then throw err
						picture = product.pictures.main
						product.pictures.main = null
						product.save (err, product) ->
							if err then throw err
							fs.unlink "#{__dirname}/public/pictures/#{picture}", (err) ->
								if err then throw err
								res.json 'deleted'
			other:
				upload: (req, res) ->
					form = new formy.IncomingForm()
					form.parse req, (err, fields, files) ->
						if err then throw err
						Product.findById req.params.id, (err, product) ->
							if err then throw err
							product.pictures.other.push files.other.name
							product.save (err, product) ->
								if err then throw err
								fs.readFile files.other.path, (err, data) ->
									if err then throw err
									newpath = "#{__dirname}/public/pictures/#{files.other.name}"
									fs.writeFile newpath, data, (writeerr) ->
										if writeerr
											product.pictures.other.splice (product.pictures.other.indexOf files.other.name), 1
											product.save (err, product) ->
												if err then throw err
												throw writeerr
										res.json product.pictures.other
				'delete': (req, res) ->
					Product.findById req.params.id, (err, product) ->
						if err then throw err
						for value, i in product.pictures.other
							if value is req.params.picture then index = i
						product.pictures.other.splice index, 1
						product.save (err, product) ->
							if err then throw err
							fs.unlink "#{__dirname}/public/pictures/#{req.params.picture}", (err) ->
								if err then throw err
								res.json product.pictures.other
		files: (req, res) ->
reports =
	find: (req, res) -> Report.find (err, reports) -> if err then throw err else res.json reports
	create: (req, res) -> Report.create req.body, (err, report) -> if err then throw err else res.json report
	read: (req, res) -> Report.findById req.params.id, (err, report) -> if err then throw err else res.json report
	update: (req, res) ->
		if req.body._id then delete req.body._id
		Report.findByIdAndUpdate req.params.id, req.body, (err, report) -> if err then throw err else res.json report
	delete: (req, res) -> Report.findByIdAndRemove req.params.id, (err, report) -> if err then throw err else res.send 200
	uploads:
		pictures:
			main:
				upload: (req, res) ->
					form = new formy.IncomingForm()
					form.parse req, (err, fields, files) ->
						if err then throw err
						Report.findById req.params.id, (err, report) ->
							if err then throw err
							report.pictures.main = files.main.name
							report.save (err, report) ->
								if err then throw err
								fs.readFile files.main.path, (err, data) ->
									if err then throw err
									newpath = "#{__dirname}/public/pictures/#{files.main.name}"
									fs.writeFile newpath, data, (writeErr) ->
										if writeErr
											report.pictures.main = null
											report.save (err, report) ->
												if err then throw err
												throw writeErr
										res.json report.pictures.main
				'delete': (req, res) ->
					Report.findById req.params.id, (err, report) ->
						if err then throw err
						picture = report.pictures.main
						report.pictures.main = null
						report.save (err, report) ->
							if err then throw err
							fs.unlink "#{__dirname}/public/pictures/#{picture}", (err) ->
								if err then throw err
								res.json 'deleted'
articles =
	find: (req, res) -> Article.find (err, articles) -> if err then throw err else res.json articles
	create: (req, res) -> Article.create req.body, (err, article) -> if err then throw err else res.json article
	read: (req, res) -> Article.findById req.params.id, (err, article) -> if err then throw err else res.json article
	update: (req, res) ->
		if req.body._id then delete req.body._id
		Article.findByIdAndUpdate req.params.id, req.body, (err, article) -> if err then throw err else res.json article
	delete: (req, res) -> Article.findByIdAndRemove req.params.id, (err, article) -> if err then throw err else res.send 200
	uploads:
		pictures:
			main:
				upload: (req, res) ->
					form = new formy.IncomingForm()
					form.parse req, (err, fields, files) ->
						if err then throw err
						Article.findById req.params.id, (err, article) ->
							if err then throw err
							article.pictures.main = files.main.name
							article.save (err, article) ->
								if err then throw err
								fs.readFile files.main.path, (err, data) ->
									if err then throw err
									newpath = "#{__dirname}/public/pictures/#{files.main.name}"
									fs.writeFile newpath, data, (writeErr) ->
										if writeErr
											article.pictures.main = null
											article.save (err, article) ->
												if err then throw err
												throw writeErr
										res.json article.pictures.main
				'delete': (req, res) ->
					Article.findById req.params.id, (err, article) ->
						if err then throw err
						picture = article.pictures.main
						article.pictures.main = null
						article.save (err, article) ->
							if err then throw err
							fs.unlink "#{__dirname}/public/pictures/#{picture}", (err) ->
								if err then throw err
								res.json 'deleted'
categories =
	find: (req, res) -> Category.find (err, categories) ->
		if err then throw err
		unless categories.length then Category.create {}, (err, categories) ->
			if err then throw err else res.json categories
		else res.json categories[0]
	update: (req, res) ->
		if req.body._id then delete req.body._id
		Category.findByIdAndUpdate req.params.id, req.body, (err, categories) -> if err then throw err else res.json categories
kits =
	find: (req, res) -> Kit.find (err, kits) ->
		if err then throw err
		unless kits.length then Kit.create {}, (err, kits) ->
			if err then throw err else res.json kits
		else res.json kits[0]
	update: (req, res) ->
		if req.body._id then delete req.body._id
		Kit.findByIdAndUpdate req.params.id, req.body, (err, kits) -> if err then throw err else res.json kits

app = do express
router = do express.Router

# app configuring
app.use (err, req, res, next) -> if err then throw err else do next
app.use (express.static "#{__dirname}/public")
app.use do body.json
app.use (body.urlencoded extended: yes)

# app endpoints configuring
router.route '/products'
.get products.find
.post products.create

router.route '/products/:id'
.get products.read
.put products.update
.delete products.delete

router.post '/products/:id/main', products.uploads.pictures.main.upload
router.delete '/products/:id/main', products.uploads.pictures.main.delete
router.post '/products/:id/other', products.uploads.pictures.other.upload
router.delete '/products/:id/other/:picture', products.uploads.pictures.other.delete

router.route '/reports'
.get reports.find
.post reports.create

router.route '/reports/:id'
.get reports.read
.put reports.update
.delete reports.delete

router.post '/reports/:id/main', reports.uploads.pictures.main.upload
router.delete '/reports/:id/main', reports.uploads.pictures.main.delete

router.route '/articles'
.get articles.find
.post articles.create

router.route '/articles/:id'
.get articles.read
.put articles.update
.delete articles.delete

router.post '/articles/:id/main', articles.uploads.pictures.main.upload
router.delete '/articles/:id/main', articles.uploads.pictures.main.delete

router.route '/categories'
.get categories.find

router.route '/categories/:id'
.put categories.update

router.route '/kits'
.get kits.find

router.route '/kits/:id'
.put kits.update

app.use '/api/v1', router

# run app
app.listen process.env.PORT or 8080, -> console.log "started on port " + process.env.PORT or 8080
















# # });
# 						# Product.findById req.params.id, (err, product) ->
# 						# 	if err then throw err
# 						# 	console.log files.main.path + ' exists', (fs.existsSync files.main.path)
# 						# 	console.log __dirname
# 						# 	fs.readFile files.main.path, (err, data) ->
# 						# 		if err then throw err
# 						# 		newpath = "#{__dirname}/public/pictures/#{files.main.name}"
# 							# product.pictures.main = files.main.name
# 							# product.save (err, product) ->
# 								# if err then throw err
# 								# console.log files.main.path
# 						# 		console.log 'exists', (fs.existsSync files.main.path)

# 								# console.log (fs.existsSync files.main.path)
# 								# if not fs.existsSync files.main.pathfs.openSync( filename, "wx" );
# 								# fs.writeFileSync( filename, data );
# 								# fs.readFile files.main.path, (err, data) ->
# 								# 	# if err then console.log err
# 								# 	# if err then console.dir err
# 								# 	# if err then throw err
# 								# 	# newpath = "#{__dirname}/public/pictures/#{files.main.name}"
# 								# 	# newpath2 = "./public/pictures/#{files.main.name}"
# 								# 	# console.log newpath
# 								# 	# console.log newpath2
# 								# 	newpath = __dirname + '/public/pictures/' + files.main.name
# 								# 	fs.writeFile newpath, data, (err) ->
# 								# 		# if err then console.log err
# 								# 		# if err then console.dir err
# 								# 		# if err then throw err
# 								# 		if err then throw err
# 								# 		res.json product.pictures.main









# 							console.log files.main.path + ' exists', (fs.existsSync files.main.path)
# 							console.log __dirname
# 						# fs.writeFile newpath, data, (err) ->
# 						# 	if err then console.log '1 writefile error', err
# 						# 	console.log '1 ' + newpath + ' exists', (fs.existsSync newpath)

# 						# fs.readdir __dirname + '/public', (err, files) ->
# 						# 	console.log 'files', files
# 						# console.log (fs.readdir __dirname + '/public')
# 						# console.log files.main.path + ' exists', (fs.existsSync files.main.path)
# 						# console.log __dirname
# 						# console.log __dirname + '/public exists', (fs.existsSync __dirname + '/public')
# 						# console.log __dirname + '/public/pictures exists', (fs.existsSync __dirname + '/public/pictures')










# 							fs.writeFile newpath, data, (err) ->
# 								if err then console.log '1 writefile error', err
# 								console.log '1 ' + newpath + ' exists', (fs.existsSync newpath)









# 							# stream = fs.createWriteStream newpath
# 							# stream.once 'open', (fd) ->
# 							# 	stream.write data
# 							# 	do stream.end
# 							# 	console.log '2 stream ended'
# 							# 	console.log '2 ' + newpath + ' exists', (fs.existsSync newpath)






# 							# fs.open newpath, 'w', (err, fd) ->
# 							# 	if err then console.log '3 fs.open error', err
# 							# 	fs.write fd, data, 0, data.length, null, (err) ->
# 							# 		if err then console.log '3 fs.write error', err
# 							# 		else fs.close (fd) ->
# 							# 			console.log '3 closed', fd
# 							# 			console.log '3 ' + newpath + ' exists', (fs.existsSync newpath)







# 							# fstream = fs.createWriteStream newpath
# 							# files.main.pipe fstream
# 							# fstream.on 'close', ->
# 							# 	console.log '4 fstream closed'
# 							# 	console.log '4 ' + newpath + ' exists', (fs.existsSync newpath)





# # app.post('/fileupload', function(req, res) {
# #     var fstream;
# #     req.pipe(req.busboy);
# #     req.busboy.on('file', function (fieldname, file, filename) {
# #         console.log("Uploading: " + filename); 
# #         fstream = fs.createWriteStream(__dirname + '/files/' + filename);
# #         file.pipe(fstream);
# #         fstream.on('close', function () {
# #             res.redirect('back');
# #         });
# #     });
# # });









# # var path = 'public/uploads/file.txt',
# # buffer = new Buffer("some content\n");

# # fs.open(path, 'w', function(err, fd) {
# #     if (err) {
# #         throw 'error opening file: ' + err;
# #     } else {
# #         fs.write(fd, buffer, 0, buffer.length, null, function(err) {
# #         if (err) throw 'error writing file: ' + err;
# #             fs.close(fd, function() {
# #             console.log('file written');
# #             })
# #         });
# #     }
# # });

# # 			var fs = require('fs');
# # var stream = fs.createWriteStream("my_file.txt");
# # stream.once('open', function(fd) {
# #   stream.write("My first row\n");
# #   stream.write("My second row\n");
# #   stream.end();
# # });
# 						# Product.findById req.params.id, (err, product) ->
# 						# 	if err then throw err
# 						# 	console.log files.main.path + ' exists', (fs.existsSync files.main.path)
# 						# 	console.log __dirname
# 						# 	fs.readFile files.main.path, (err, data) ->
# 						# 		if err then throw err
# 						# 		newpath = "#{__dirname}/public/pictures/#{files.main.name}"
# 							# product.pictures.main = files.main.name
# 							# product.save (err, product) ->
# 								# if err then throw err
# 								# console.log files.main.path
# 						# 		console.log 'exists', (fs.existsSync files.main.path)

# 								# console.log (fs.existsSync files.main.path)
# 								# if not fs.existsSync files.main.pathfs.openSync( filename, "wx" );
# 								# fs.writeFileSync( filename, data );
# 								# fs.readFile files.main.path, (err, data) ->
# 								# 	# if err then console.log err
# 								# 	# if err then console.dir err
# 								# 	# if err then throw err
# 								# 	# newpath = "#{__dirname}/public/pictures/#{files.main.name}"
# 								# 	# newpath2 = "./public/pictures/#{files.main.name}"
# 								# 	# console.log newpath
# 								# 	# console.log newpath2
# 								# 	newpath = __dirname + '/public/pictures/' + files.main.name
# 								# 	fs.writeFile newpath, data, (err) ->
# 								# 		# if err then console.log err
# 								# 		# if err then console.dir err
# 								# 		# if err then throw err
# 								# 		if err then throw err
# 								# 		res.json product.pictures.main

