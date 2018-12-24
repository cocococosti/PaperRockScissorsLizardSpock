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
	attr_accessor :nombre, :patron

	def initialize (nombre, patron)
		@nombre = nombre
		@patron = patron
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


class Manual < Estrategia

	def prox(m)
		if m == "papel"
			@patron = Papel.new("papel")
		elsif m == "piedra"
			@patron = Piedra.new("piedra")
		elsif m == "tijeras"
			@patron = Tijeras.new("tijeras")
		elsif m == "spock"
			@patron = Spock.new("spock")
		elsif m == "lagarto"
			@patron = Lagarto.new("lagarto")
		else
			raise "Error."
		end
	end


	def to_s
		s = "El jugador " + @nombre + " con de la estrategia Manual"
	end
end

class Copiar < Estrategia



	def prox(m)
		if m.to_s == "papel"
			@patron = Papel.new("papel")
		elsif m.to_s == "piedra"
			@patron = Piedra.new("piedra")
		elsif m.to_s == "tijeras"
			@patron = Tijeras.new("tijeras")
		elsif m.to_s == "spock"
			@patron = Spock.new("spock")
		elsif m.to_s == "lagarto"
			@patron = Lagarto.new("lagarto")
		else
			raise "Error."
		end
		@patron				
	end

	def to_s
		s = "El jugador " + @nombre + " con la estrategia Copiar"
	end

	
end									

class Partida
	attr_accessor :j1, :j2, :s1, :s2, :resultado

	def initialize partida
		# Nombres de los jugadores
		@j1 = partida.keys[0]
		@j2 = partida.keys[1]

		# Estrategias de los jugadores
		@s1 = partida.values[0]
		@s2 = partida.values[1]

		# Inicializamos el mapa con los resultados
		@resultado = Hash[j1 => 0, j2 => 0, "rondas" => 0]
	end


	def rondas (n)
		# Obtenemos proxima jugada del jugador 1
		if s1.getPatron == "copiar"
			mano1 = Piedra.new "piedra"
		elsif s1.getPatron == "uniforme"  or s1.getPatron == "sesgada"
			mano1 = s1.prox
		end

		# Obtenemos proxima jugada del jugador 2
		if s2.getPatron == "copiar"
			mano2 = s2.prox mano1
		elsif s2.getPatron == "uniforme"  or s2.getPatron == "sesgada"
			mano2 = s2.prox
		end

		puts s1.to_s
		puts mano1.to_s

		puts s2.to_s
		puts mano2.to_s

		# Obtenemos el puntaje de la ronda
		puntaje = mano1.puntos(mano2)

		# El primer valor de la tupla obtenida es el puntaje del jugador 1
		@resultado[j1] += puntaje[0]

		# El segundo valor de la tupla obtenida es el puntaje del jugador 2
		@resultado[j2] += puntaje[1]


		(2..n).each do |i|
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

			puts s1.to_s
			puts mano1.to_s

			puts s2.to_s
			puts mano2.to_s

			# Obtenemos el puntaje de la ronda
			puntaje = mano1.puntos(mano2)

			# El primer valor de la tupla obtenida es el puntaje del jugador 1
			@resultado[j1] += puntaje[0]

			# El segundo valor de la tupla obtenida es el puntaje del jugador 2
			@resultado[j2] += puntaje[1]
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

piedra = Piedra.new ("piedra")
papel = Papel.new ("papel")
tijeras = Tijeras.new ("tijeras")
lagarto = Lagarto.new ("lagarto")
spock = Spock.new ("spock")

j1 = Uniforme.new "Ana", "uniforme", [piedra, papel, tijeras, lagarto, spock]
j2 = Uniforme.new "Juan", "uniforme", [piedra, papel, tijeras, lagarto, spock]

m = Partida.new Hash["Ana" => j1, "Juan" => j2]

r = m.rondas(3)

puts r['Ana']
puts r['Juan']
puts r['rondas']

puts "################"

pesos = Hash[piedra => 2, papel => 5, tijeras => 4, lagarto => 3, spock => 1]


j1 = Sesgada.new "Ana", "sesgada", pesos
j2 = Sesgada.new "Juan", "sesgada", pesos

m = Partida.new Hash["Ana" => j1, "Juan" => j2]

r = m.rondas(3)

puts r['Ana']
puts r['Juan']
puts r['rondas']

puts "################"
