'use strict'

# dependencies
express = require 'express'
body = require 'body-parser'
mongoose = require 'mongoose'
extend = require 'extend'
formy = require 'formidable'
fs = require 'fs'

# connect db
mongoose.connect 'mongodb://localhost:27017/bsound-dev'

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
	type: type: String, enum: ['loudspeackers', 'speackers']
	description: title: String, short: String, full: String
	pictures: main: String, other: [String]
	related: [type: mongoose.Schema.Types.ObjectId, ref: 'Product']
Report = mongoose.model 'Report', new mongoose.Schema
	title: String
	date: Date
	text: String
	picture: String
Article = mongoose.model 'Article', new mongoose.Schema
	title: String
	date: Date
	text: String
	picture: String
Kit = mongoose.model 'Kit', new mongoose.Schema
	tree: [mongoose.Schema.Types.Mixed]
Category = mongoose.model 'Category', new mongoose.Schema
	tree: [mongoose.Schema.Types.Mixed]

# routes configuring
products =
	find: (req, res) -> Product.find (err, products) -> if err then throw err else res.json products
	create: (req, res) -> Product.create req.body, (err, product) -> if err then throw err else res.json product
	read: (req, res) -> Product.findById req.params.id, (err, product) -> if err then throw err else res.json product
	update: (req, res) -> Product.findByIdAndUpdate req.params.id, req.body, (err, product) -> if err then throw err else res.json product
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
									fs.writeFile newpath, data, (err) ->
										if err then throw err
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
									fs.writeFile newpath, data, (err) ->
										if err then throw err
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
	update: (req, res) -> Report.findByIdAndUpdate req.params.id, req.body, (err, report) -> if err then throw err else res.json report
	delete: (req, res) -> Report.findByIdAndRemove req.params.id, (err, report) -> if err then throw err else res.send 200
articles =
	find: (req, res) -> Article.find (err, articles) -> if err then throw err else res.json articles
	create: (req, res) -> Article.create req.body, (err, article) -> if err then throw err else res.json article
	read: (req, res) -> Article.findById req.params.id, (err, article) -> if err then throw err else res.json article
	update: (req, res) -> Article.findByIdAndUpdate req.params.id, req.body, (err, article) -> if err then throw err else res.json article
	delete: (req, res) -> Article.findByIdAndRemove req.params.id, (err, article) -> if err then throw err else res.send 200
categories =
	find: (req, res) -> Category.find (err, categories) ->
		if err then throw err
		unless categories.length then Category.create {}, (err, categories) ->
			if err then throw err else res.json categories
		else res.json categories[0]
	update: (req, res) -> Category.findByIdAndUpdate req.params.id, req.body, (err, categories) -> if err then throw err else res.json categories
kits =
	find: (req, res) -> Kit.find (err, kits) ->
		if err then throw err
		unless kits.length then Kit.create {}, (err, kits) ->
			if err then throw err else res.json kits
		else res.json kits[0]
	update: (req, res) -> Kit.findByIdAndUpdate req.params.id, req.body, (err, kits) -> if err then throw err else res.json kits

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

router.route '/articles'
.get articles.find
.post articles.create

router.route '/articles/:id'
.get articles.read
.put articles.update
.delete articles.delete

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
app.listen 8080, -> console.log "started on port 8080"

