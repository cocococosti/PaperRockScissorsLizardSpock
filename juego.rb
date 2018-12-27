# Fuente: https://www.rubyguides.com/2016/05/weighted-random-numbers/
def random_weighted(weighted)
	max    = sum_of_weights(weighted)
	target = rand(1..max)
	weighted.each do |item, weight|
		return item if target <= weight
		target -= weight
	end
end

def sum_of_weights(weighted)

	weighted.inject(0) { |sum, (item, weight)| sum + weight }
end

class Jugada

	attr_reader :jugada

	def initialize(mano)
		@jugada = mano
	end

	def to_s
		s = @jugada
		s
	end

end

class Piedra < Jugada

	def puntos(j)
		if j.to_s == "tijeras"
			resultado = [1,0]
		elsif j.to_s == "papel" 
			resultado = [0,1]
		elsif j.to_s == "spock"
			resultado = [0,1]
		elsif j.to_s == "lagarto"
			resultado = [1,0]
		elsif j.to_s == "piedra"
			resultado = [0,0]
		else
			raise "Movimiento invalido"
		end
		resultado
	end
end


class Papel < Jugada

	def puntos(j)
		if j.to_s == "piedra"
			resultado = [1,0]
		elsif j.to_s == "tijeras"
			resultado = [0,1]
		elsif j.to_s == "spock"
			resultado = [1,0]
		elsif j.to_s == "lagarto"
			resultado = [0,1]
		elsif j.to_s == "papel"
			resultado = [0,0]
		else
			raise "Movimiento invalido"
		end
		resultado
	end
end		

class Tijeras < Jugada

	def puntos(j)
		if j.to_s == "papel"
			resultado = [1,0]
		elsif j.to_s == "piedra"
			resultado = [0,1]
		elsif j.to_s == "spock"
			resultado = [0,1]
		elsif j.to_s == "lagarto"
			resultado = [1,0]
		elsif j.to_s == "tijeras"
			resultado = [0,0]
		else
			raise "Movimiento invalido"
		end					
		resultado
	end
end	

class Spock < Jugada

	def puntos(j)
		if j.to_s == "piedra"
			resultado = [1,0]
		elsif j.to_s == "papel"
			resultado = [0,1]
		elsif j.to_s == "lagarto"
			resultado = [0,1]
		elsif j.to_s == "tijeras"
			resultado = [1,0]
		elsif j.to_s == "spock"
			resultado = [0,0]
		else 
			raise "Movimiento invalido"
		end
		resultado
	end
end

class Lagarto < Jugada

	def puntos(j)
		if j.to_s == "papel"
			resultado = [1,0]
		elsif j.to_s == "piedra"
			resultado = [0,1]
		elsif j.to_s == "tijeras"
			resultado = [0,1]
		elsif j.to_s == "spock"
			resultado = [1,0]
		elsif j.to_s == "lagarto"
			resultado = [0,0]
		else 
			raise "Movimiento invalido"
		end
		resultado
	end
end	

class Estrategia
	attr_accessor :nombre, :patron, :semilla

	def initialize (nombre, patron)
		@nombre = nombre
		@patron = patron
		@semilla = 42
		@random = Random.new(@semilla)
	end

	def getPatron
		@patron
	end

	def to_s
		s = "El jugador " + @nombre
	end
	
end		

class Uniforme < Estrategia

	attr_accessor :nombre, :patron, :jugadas

	def initialize (nombre, patron, jugadas)
		@nombre = nombre
		@patron = patron
		if jugadas.length < 1
			raise "Error"
		end
		
		@jugadas = jugadas.uniq
	end

	def prox
		@jugadas.sample
	end

	def to_s
		s = "El jugador " + @nombre + " con la estrategia Uniforme"
	end
end

class Sesgada < Estrategia

	attr_accessor :nombre, :patron, :jugadas

	def initialize (nombre, patron, jugadas)
		@nombre = nombre
		@patron = patron
		if jugadas.length < 1
			raise "Error"
		end

		@jugadas = jugadas
	end

	def prox
		random_weighted @jugadas
		
	end

	def to_s
		s = "El jugador " + @nombre + " con la estrategia Sesgada"
	end
end

class Pensar < Estrategia
	def initialize (nombre, patron)
		super(nombre, patron)
		@r = 0
		@p = 0
		@t = 0
		@l = 0
		@s = 0
	end

	def prox m
		if m.to_s == "papel"
			@p += 1
		elsif m.to_s == "piedra"
			@r += 1
		elsif m.to_s == "tijeras"
			@t += 1
		elsif m.to_s == "spock"
			@s += 1
		elsif m.to_s == "lagarto"
			@l += 1
		elsif m.to_s == ""
			# no hacer nada
		else
			raise "Error."
		end

		max = @p + @r + @t + @l + @s -1
		if max <= 0
			max = 0
			n = 0
		else

			
			n = @random.rand(max)
		end

		puts "EL NUM ES #{n}"

		if (n >= 0 and n < @r) or (n == 0)
			mano = Piedra.new("piedra")
		elsif n >= @r and n < @r+@p 
			mano = Papel.new("papel")
		elsif n >= @r+@p and n < @r+@p+@t
			mano = Tijeras.new("tijeras")
		elsif n >= @r+@p+@t and n < @r+@p+@t+@l
			mano = Lagarto.new("lagarto")
		elsif n >= @r+@p+@t+@l and n < @r+@p+@t+@l+@s
			mano = Spock.new("spock")
		end

		mano			
			
	end

	def reset
		@r = 0
		@p = 0
		@t = 0
		@l = 0
		@s = 0
	end

end


class Manual < Estrategia

	def prox(m)
		if m == "papel"
			juego = Papel.new("papel")
		elsif m == "piedra"
			juego = Piedra.new("piedra")
		elsif m == "tijeras"
			juego = Tijeras.new("tijeras")
		elsif m == "spock"
			juego = Spock.new("spock")
		elsif m == "lagarto"
			juego = Lagarto.new("lagarto")
		else
			raise "Error."
		end
		juego
	end


	def to_s
		s = "El jugador " + @nombre + " con de la estrategia Manual"
	end
end

class Copiar < Estrategia



	def prox(m)
		if m.to_s == "papel"
			juego = Papel.new("papel")
		elsif m.to_s == "piedra"
			juego = Piedra.new("piedra")
		elsif m.to_s == "tijeras"
			juego = Tijeras.new("tijeras")
		elsif m.to_s == "spock"
			juego = Spock.new("spock")
		elsif m.to_s == "lagarto"
			juego = Lagarto.new("lagarto")
		else
			raise "Error."
		end
		juego				
	end

	def to_s
		s = "El jugador " + @nombre + " con la estrategia Copiar"
	end

	
end									

class Partida
	attr_accessor :j1, :j2, :s1, :s2, :resultado, :app

	def initialize partida, app
		# Nombres de los jugadores
		@j1 = partida.keys[0]
		@j2 = partida.keys[1]

		# Estrategias de los jugadores
		@s1 = partida.values[0]
		@s2 = partida.values[1]

		# Inicializamos el mapa con los resultados
		@resultado = Hash[j1 => 0, j2 => 0, "rondas" => 0]
		@app = app

		
	end


	def rondas (n)
		@app.clear
		@app.background "versus.jpg"

		manual1 = false
		manual2 = false
		
		# Obtenemos proxima jugada del jugador 1
		if @s1.getPatron == "copiar"
			mano1 = Piedra.new "piedra"
			jugada1 = mano1.to_s
		elsif @s1.getPatron == "uniforme"  or @s1.getPatron == "sesgada"
			mano1 = @s1.prox
			jugada1 = mano1.to_s
		elsif @s1.getPatron == "pensar"
			mano1 = @s1.prox ""
			jugada1 = mano1.to_s
		elsif @s1.getPatron == "manual"
			manual1 = true
			
		end

		# Obtenemos proxima jugada del jugador 2
		if @s2.getPatron == "copiar"
			mano2 = @s2.prox mano1
			jugada2 = mano2.to_s
		elsif @s2.getPatron == "uniforme"  or @s2.getPatron == "sesgada"
			mano2 = @s2.prox
			jugada2 = mano2.to_s
		elsif @s2.getPatron == "pensar"
			mano2 = @s2.prox mano1
			jugada2 = mano2.to_s
		elsif @s2.getPatron == "manual"
			manual2 = true
		end

		if manual1
			@app.button "piedra" do
				imagen = @app.image "piedra2.png"
			end
			@app.button "papel" do
				imagen = @app.image "papel2.png"
			end
			@app.button "tijeras" do
				imagen = @app.image "tijeras2.png"
			end
			@app.button "spock" do
				imagen = @app.image "spock2.png"
			end
			@app.button "lagarto" do
				imagen = @app.image "lizard2.png"
			end
		else
			@app.button "jugar" do

				if jugada1 == "piedra"
					@app.stack :top => '200', :left => '40', :width => '200', :height => '300' do
						imagen = @app.image "piedra2.png"
					end

				elsif jugada1 == "papel"
					@app.stack :top => '200', :left => '40', :width => '200', :height => '300' do
						imagen = @app.image "papel2.png"
							
					end

				elsif jugada1 == "tijeras"
					@app.stack :top => '200', :left => '40', :width => '200', :height => '300' do
						imagen = @app.image "tijeras2.png"
							
					end

				elsif jugada1 == "lagarto"
					@app.stack :top => '200', :left => '40', :width => '200', :height => '300' do
						imagen = @app.image "lizard2.png"
					end

				elsif jugada1 == "spock"
					@app.stack :top => '200', :left => '40', :width => '200', :height => '300' do
						imagen = @app.image "spock2.png"
					end
				end

				if @s1.getPatron == "copiar"
					mano1 = mano2
					jugada1 = mano1.to_s
				elsif @s1.getPatron == "uniforme"  or @s1.getPatron == "sesgada"
					mano1 = @s1.prox
					jugada1 = mano1.to_s
				elsif @s1.getPatron == "pensar"
					mano1 = @s1.prox ""
					jugada1 = mano1.to_s
				elsif @s1.getPatron == "manual"
					manual1 = true
			
				end
			end
		end

		if manual2
			@app.button "piedra" do
				imagen = @app.image "piedra.png"
			end
			@app.button "papel" do
				imagen = @app.image "papel.png"
			end
			@app.button "tijeras" do
				imagen = @app.image "tijeras.png"
			end
			@app.button "spock" do
				imagen = @app.image "spock.png"
			end
			@app.button "lagarto" do
				imagen = @app.image "lizard.png"
			end
		else
			@app.button "jugar" do

				if jugada2 == "piedra"
					@app.stack :top => '200', :left => '580', :width => '200', :height => '300' do
						imagen = @app.image "piedra.png"
					end

				elsif jugada2 == "papel"
					@app.stack :top => '200', :left => '580', :width => '200', :height => '300' do
						imagen = @app.image "papel.png"
					end

				elsif jugada2 == "tijeras"
					@app.stack :top => '200', :left => '580', :width => '200', :height => '300' do
						imagen = @app.image "tijeras.png"
					end

				elsif jugada2 == "lagarto"
					@app.stack :top => '200', :left => '580', :width => '200', :height => '300' do
						imagen = @app.image "lizard.png"
					end

				elsif jugada2 == "spock"
					@app.stack :top => '200', :left => '580', :width => '200', :height => '300' do
						imagen = @app.image "spock.png"
					end
				end

				if @s2.getPatron == "copiar"
					mano2 = @s2.prox mano1
					jugada2 = mano2.to_s
				elsif @s2.getPatron == "uniforme"  or @s2.getPatron == "sesgada"
					mano2 = @s2.prox
					jugada2 = mano2.to_s
				elsif @s2.getPatron == "pensar"
					mano2 = @s2.prox mano1
					jugada2 = mano2.to_s
				elsif @s2.getPatron == "manual"
					manual2 = true
				end

			end
		end

		@app.button "Siguiente ronda" do
			
			

			# Obtenemos el puntaje de la ronda
			puntaje = mano1.puntos(mano2)

			# El primer valor de la tupla obtenida es el puntaje del jugador 1
			@resultado[j1] += puntaje[0]

			# El segundo valor de la tupla obtenida es el puntaje del jugador 2
			@resultado[j2] += puntaje[1]
			if puntaje[0] == 1
				@app.para "El ganador de esta ronda es el jugador 1"
			elsif puntaje[1] == 1
				
				@app.para "El ganador de esta ronda es el jugador 2"
			else 
				@app.para "Empate"
			end

			@resultado["rondas"] += 1

			if @resultado["rondas"] == n
				@app.para "juego terminado con #{n} rondas"
				if @resultado[j1] > @resultado[j2]
					@app.para "El ganador es el jugador 1"
				elsif @resultado[j1] < @resultado[j2]
					@app.para "El ganador es el jugador 2"
				else
					@app.para "Empate!"
				end
				return @resultado
			end
					
		end
		@resultado


		
		
		
	end

	def alcanzar (n)

		fin = false

		# Obtenemos proxima jugada del jugador 1
		if s1.getPatron == "copiar"
			mano1 = Piedra.new "piedra"
		elsif s1.getPatron == "uniforme"  or s1.getPatron == "sesgada"
			mano1 = s1.prox

		end

		# Obtenemos proxima jugada del jugador 2
		if s2.getPatron == "copiar"
			mano2 = s2.prox mano1
		elsif s2.getPatron == "uniforme" or s2.getPatron == "sesgada" 
			mano2 = s2.prox
		end

		@resultado["rondas"] += 1
		# Obtenemos el puntaje de la ronda
		puntaje = mano1.puntos(mano2)

		# El primer valor de la tupla obtenida es el puntaje del jugador 1
		@resultado[j1] += puntaje[0]

		# El segundo valor de la tupla obtenida es el puntaje del jugador 2
		@resultado[j2] += puntaje[1]

		if (@resultado[j1] == n or @resultado[j2] == n)
			fin = true
		end

		while fin do

			@resultado["rondas"] += 1

			if s1.getPatron == "copiar"
				mano1 = s1.prox mano2
			elsif s1.getPatron == "uniforme"  or s1.getPatron == "sesgada"
				mano1 = s1.prox
			end

			# Obtenemos proxima jugada del jugador 2
			if s2.getPatron == "copiar"
				mano2 = s2.prox mano1
			elsif s2.getPatron == "uniforme"  or s2.getPatron == "sesgada"
				mano2 = s2.prox
			end

			# Obtenemos el puntaje de la ronda
			puntaje = mano1.puntos(mano2)

			# El primer valor de la tupla obtenida es el puntaje del jugador 1
			@resultado[j1] += puntaje[0]

			# El segundo valor de la tupla obtenida es el puntaje del jugador 2
			@resultado[j2] += puntaje[1]

			if (@resultado[j1] == n or @resultado[j2] == n)
				fin = true
			end
		end

		@resultado
	end

	def reset 
		@resultado["rondas"] = 0
		@resultado[j1] = 0
		@resultado[j2] = 0
	end
end

titulo = "Piedra Papel Tijeras Lagarto Spock"

# Ventana principal
Shoes.app(width: 1000, height:572, title:titulo) do
	

	# Stack principal
	inicio = stack width: 1000, height:572 do

		# Estrategias a usar por cada usuario
		estrategia1 = ""
		estrategia2 = ""

		# Fondo de la ventana principal
		background "fondo.jpg"

		# Al hacer click en el boton inicio limpiamos la ventana
		# y agregamos nuevos elementos
		@botonInicio = button "Empezar"
		@botonInicio.click do

			inicio.clear
			background "fondo.jpg"
			
			inicio.append do

				# Agregamos stack de botones con las opciones de estrategias
				stack margin: 300 do 

					para "Jugador 1"
					para "Escoge una estrategia de juego"

					button "Manual" do
						estrategia1 = "manual"	
					end

					flow  do
						button "Uniforme" do
							estrategia1 = "uniforme"
						end

						button "Sesgada" do
							estrategia1 = "sesgada"	
						end
					end

					flow do
						button "Copiar" do
							estrategia1 = "copiar"	
						end

						button "Pensar" do
							estrategia1 = "pensar"	
						end

					end

					button "Siguiente" do

						if estrategia1 != ""

							inicio.clear
							background "fondo.jpg"

							inicio.append do
								stack margin: 300 do

									para "Jugador 2"
									para "Escoge una estrategia de juego"

									button "Manual" do
										estrategia2 = "manual"
									end

									flow  do
										button "Uniforme" do
											estrategia2 = "uniforme"
										end

										button "Sesgada" do
											estrategia2 = "sesgada"	
										end
									end

									flow do
										button "Copiar" do
											estrategia2 = "copiar"	
										end

										button "Pensar" do
											estrategia2 = "pensar"
										end
									end

									button "Siguiente" do

										if estrategia2 != ""
											inicio.clear
											background "fondo.jpg"
											@puntos = ""
											@rondas = ""
											inicio.append do
										      	flow margin: 300 do
										      		stack do
														para "Rondas"
														@r = edit_line
										      		end
										      		stack do
										 	     		para "Puntos"
										 	     		@pu = edit_line
										        	end
										        	button "OK" do
										       			@rondas = @r.text
										    	   		@puntos = @pu.text
														
										        		
											        	inicio.clear
										        		if @puntos != "" or @rondas != ""
										        				
															piedra = Piedra.new ("piedra")
															papel = Papel.new ("papel")
															tijeras = Tijeras.new ("tijeras")
															lagarto = Lagarto.new ("lagarto")
															spock = Spock.new ("spock")
															pesos = Hash[piedra => 2, papel => 5, tijeras => 4, lagarto => 3, spock => 1]


															if estrategia1 == "uniforme"
																j1 =  Uniforme.new "Ana", "uniforme", [piedra, papel, tijeras, lagarto, spock]
															elsif estrategia1 == "sesgada"
																j1 = Sesgada.new "Ana", "sesgada", pesos
															elsif estrategia1 == "manual"
																j1 = Manual.new "Ana", "manual"
															elsif estrategia1 == "copiar"
																j1 = Copiar.new "Ana", "copiar"
															elsif estrategia1 == "pensar"
																j1 = Pensar.new "Ana", "pensar"
															end
																
															if estrategia2 == "uniforme"
																j2 =  Uniforme.new "Juan", "uniforme", [piedra, papel, tijeras, lagarto, spock]
															elsif estrategia2 == "sesgada"
																j2 = Sesgada.new "Juan", "sesgada", pesos
															elsif estrategia2 == "manual"
																j2 = Manual.new "Juan", "manual"
															elsif estrategia2 == "copiar"
																j2 = Copiar.new "Juan", "copiar"
															elsif estrategia2 == "pensar"
																j2 = Pensar.new "Juan", "pensar"
															end

															m = Partida.new Hash["Ana" => j1, "Juan" => j2], self
															
															r = m.rondas(6)

															#prueba inicio, estrategia1, estrategia2
																


															#r = m.rondas(rondas, inicio)

										        			#jugar2(inicio, estrategia1, estrategia2, @puntos, @rondas)
										        		
											        	end
										        	end
										      	end
											end
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end
end



def jugar inicio, jugada1,jugada2, manual1, manual2
	if manual1
		inicio.button "piedra" do
			inicio.image "piedra2.png"
		end
		inicio.button "papel" do
			inicio.image "papel2.png"
		end
		inicio.button "tijeras" do
			inicio.image "tijeras2.png"
		end
		inicio.button "spock" do
			inicio.image "spock2.png"
		end
		inicio.button "lagarto" do
			inicio.image "lizard2.png"
		end
	else
		inicio.button "jugar" do

			if jugada1 == "piedra"
				inicio.stack :top => '200', :left => '40', :width => '200', :height => '300' do
					inicio.image "piedra2.png"
				end

			elsif jugada1 == "papel"
				inicio.stack :top => '200', :left => '40', :width => '200', :height => '300' do
					inicio.image "papel2.png"
						
				end

			elsif jugada1 == "tijeras"
				inicio.stack :top => '200', :left => '40', :width => '200', :height => '300' do
					inicio.image "tijeras2.png"
						
				end

			elsif jugada1 == "lagarto"
				inicio.stack :top => '200', :left => '40', :width => '200', :height => '300' do
					inicio.image "lizard2.png"
				end

			elsif jugada1 == "spock"
				inicio.stack :top => '200', :left => '40', :width => '200', :height => '300' do
					inicio.image "spock2.png"
				end
			end
		end
	end

	if manual2
		inicio.button "piedra" do
			inicio.image "piedra.png"
			return
		end
		inicio.button "papel" do
			inicio.image "papel.png"
			return
		end
		inicio.button "tijeras" do
			inicio.image "tijeras.png"
			return
		end
		inicio.button "spock" do
			inicio.image "spock.png"
			return
		end
		inicio.button "lagarto" do
			inicio.image "lizard.png"
			return
		end
	else
		inicio.button "jugar" do

			if jugada2 == "piedra"
				inicio.stack :top => '200', :left => '580', :width => '200', :height => '300' do
					inicio.image "piedra.png"
				end

			elsif jugada2 == "papel"
				inicio.stack :top => '200', :left => '580', :width => '200', :height => '300' do
					inicio.image "papel.png"
				end

			elsif jugada2 == "tijeras"
				inicio.stack :top => '200', :left => '580', :width => '200', :height => '300' do
					inicio.image "tijeras.png"
				end

			elsif jugada2 == "lagarto"
				inicio.stack :top => '200', :left => '580', :width => '200', :height => '300' do
					inicio.image "lizard.png"
				end

			elsif jugada2 == "spock"
				inicio.stack :top => '200', :left => '580', :width => '200', :height => '300' do
					inicio.image "spock.png"
				end
			end
		end
	end


end


def jugarManual inicio
	inicio.append do
		background "versus.jpg"

		partida = flow do 
			col1 = flow :width => '50%', :top => '500', :left => '15' do 
				button "Piedra" do
					inicio.append do
						stack :top => '200', :left => '40', :width => '200', :height => '300' do
							piedra = image "piedra2.png"
						end
					end
				end

				button "Papel" do
					inicio.append do
						stack :top => '200', :left => '40', :width => '200', :height => '300' do
							papel = image "papel2.png"
						end
					end
				end

				button "Tijeras" do
					inicio.append do
						stack :top => '200', :left => '40', :width => '200', :height => '300' do
							tijeras = image "tijeras2.png"
						end
					end
				end

				button "Lagarto" do
					inicio.append do
						stack :top => '200', :left => '40', :width => '200', :height => '300' do
							lagarto = image "lizard2.png"
						end
					end
				end

				button "Spock" do
					inicio.append do
						stack :top => '200', :left => '40', :width => '200', :height => '300' do
							spock = image "spock2.png"
						end
					end
				end

			end

			flow :width => '50%', :top => '500', :left => '530' do 
				button "Piedra" do
					inicio.append do
						stack :top => '200', :left => '580', :width => '200', :height => '300' do
							piedra = image "piedra.png"
						end
					end
				end

				button "Papel" do
					inicio.append do
						stack :top => '200', :left => '580', :width => '200', :height => '300' do
							piedra = image "papel.png"
						end
					end
				end

				button "Tijeras" do
					inicio.append do
						stack :top => '200', :left => '580', :width => '200', :height => '300' do
							piedra = image "tijeras.png"
						end
					end
				end

				button "Lagarto" do
					inicio.append do
						stack :top => '200', :left => '580', :width => '200', :height => '300' do
							piedra = image "lizard.png"
						end
					end
				end

				button "Spock" do
					inicio.append do
						stack :top => '200', :left => '580', :width => '200', :height => '300' do
							piedra = image "spock.png"
						end
					end
				end
			end
		end
	end
end


