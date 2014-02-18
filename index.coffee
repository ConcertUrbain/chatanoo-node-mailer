io = require('socket.io-client')
socket = io.connect('http://notify.chatanoo.org:3131')

mandrill = require('node-mandrill')('c94rNO7vJBGKY4cWeAENDw')

socket.on 'connect', ()->
	console.log('Connected to Chatanoo Notify Server!')

socket.on 'items', (data)->
	switch data.method
		when "addItem"
			item = data.params[0]
			# content = """
			# 		Titre: #{item.title}
			# 		Description: #{item.description}
			# 		"""
			content = """
					Une nouvelle contribution (#{item.id}) à été ajoutée à la mosaïc
					"""

			for email in ['carolannbraun@free.fr', 'mes-idees-aussi@cg94.fr']
				mandrill '/messages/send',
					message:
						from_email: 'admin@chatanoo.org'
						to: [
							{ email: email }
						]
						subject: '[Mes Idées Aussi] Nouvelle contribution'
						text: content
					, (error, response)->
						return console.log( JSON.stringify(error) ) if (error)
						console.log response
		
	