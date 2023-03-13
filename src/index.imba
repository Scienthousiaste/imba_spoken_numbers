tag app
	prop n_digits = 10
	prop digits = []
	prop begining? = true
	prop recalling? = false
	prop answer = ""
	prop index = 0
	prop interval = 1000

	<self @recall=(do recalling? = true)>
		<header>
			<h1> "Spoken Numbers"
		<body>
			<div> if begining?
				<label htmlFor="number-digits"> "Number of digits"
					<input name="number-digits" type="number" bind=n_digits min=1>
				<button @click=start!> "Start"

			<div> if recalling?
				<label htmlFor="number-digits-recall"> "Verify digits"
					<input name="number-digits-recall" type="text" bind=answer>
				<button @click=verify!> "Verify"
				<button @click=restart!> "Restart"

			for i in [0...10]
				<audio.audio_digits src="/assets/{i}.mp3">

	def start()
		begining? = false
		digits = for i in [0...n_digits]
			Math.floor(Math.random! * 10)
		play_sounds(digits)

	def play_sounds()
		def step()
			let all_sounds = document.getElementsByClassName('audio_digits')
			let expected = Date.now! + interval
			let dt = Date.now! - expected

			if index < digits.length
				all_sounds[digits[index]].play!
				index += 1
				expected += interval
				setTimeout(step, Math.max(0, interval - dt))
			else
				emit("recall")

		setTimeout(step, interval)

				
	def verify()
		if answer === digits.join ''
			console.log "woop woop"

	def restart()
		n_digits = 10
		digits = []
		begining? = true
		recalling? = false
		answer = ""
		index = 0
		interval = 1000

imba.mount <app>
