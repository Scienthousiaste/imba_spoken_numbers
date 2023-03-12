tag app
	prop n_digits = 10
	prop digits = []

	<self>
		<header>
			<h1> "Spoken Numbers"
		<body>
			<label htmlFor="number-digits"> "Number of digits"
				<input name="number-digits" type="number" bind=n_digits min=1>
			<button @click=start(n_digits)> "Start"

			for i in [0...10]
				<audio.audio_digits src="/assets/{i}.mp3">

	def start(n_digits)
		const all_sounds = document.getElementsByClassName('audio_digits')
		digits = []
		for i in [0...n_digits]
			digits.push(Math.floor(Math.random() * 10))
		play_sounds(digits, all_sounds)

	def play_sounds(digits, all_sounds)
		console.log(digits)
		let interval = 1000
		let expected = Date.now() + interval
		let index = 0

		def step()
			let dt = Date.now() - expected

			if index < digits.length
				all_sounds[digits[index]].play()
				index += 1
				expected += interval
				setTimeout(step, Math.max(0, interval - dt))

		setTimeout(step, interval)

imba.mount <app>
