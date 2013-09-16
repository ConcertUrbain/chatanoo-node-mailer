io = require('socket.io-client')
socket = io.connect('http://notify.chatanoo.org:3131')

mandrill = require('node-mandrill')('c94rNO7vJBGKY4cWeAENDw')

socket.on 'connect', ()->
	console.log('Connected to Chatanoo Notify Server!')

socket.on 'items', (data)->
	switch data.method
		when "addItem"
			item = data.params[0]
			content = """
					Titre: #{item.title}
					Description: #{item.description}
					"""

			mandrill '/messages/send',
				message:
					from_email: 'admin@chatanoo.org'
					to: [
						{ email: 'carolannbraun@free.fr' }
						# { email: 'mathieu.desve@me.com' }
					]
					subject: '[Chatanoo] Nouvelle contribution'
					text: content
				, (error, response)->
					return console.log( JSON.stringify(error) ) if (error)
					console.log response
		
	