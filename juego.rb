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
		if j == "tijeras"
			resultado = [1,0]
		elsif j == "papel" 
			resultado = [0,1]
		elsif j == "spock"
			resultado = [0,1]
		elsif j == "lagarto"
			resultado = [1,0]
		elsif j == "piedra"
			resultado = [0,0]
		else
			raise "Movimiento invalido"
		end
		resultado
	end
end

pi = Piedra.new "piedra"
puts pi
puts pi.puntos("tijeras").to_s

class Papel < Jugada

	def puntos(j)
		if j == "piedra"
			resultado = [1,0]
		elsif j == "tijeras"
			resultado = [0,1]
		elsif j == "spock"
			resultado = [1,0]
		elsif j == "lagarto"
			resultado = [0,1]
		elsif j == "papel"
			resultado = [0,0]
		else
			raise "Movimiento invalido"
		end
		resultado
	end
end		

class Tijeras < Jugada

	def puntos(j)
		if j == "papel"
			resultado = [1,0]
		elsif j == "piedra"
			resultado = [0,1]
		elsif j == "spock"
			resultado = [0,1]
		elsif j == "lagarto"
			resultado = [1,0]
		elsif j == "tijeras"
			resultado = [0,0]
		else
			raise "Movimiento invalido"
		end					
		resultado
	end
end	

class Spock < Jugada

	def puntos(j)
		if j == "piedra"
			resultado = [1,0]
		elsif j == "papel"
			resultado = [0,1]
		elsif j == "lagarto"
			resultado = [0,1]
		elsif j == "tijeras"
			resultado = [1,0]
		elsif j == "spock"
			resultado = [0,0]
		else 
			raise "Movimiento invalido"
		end
		resultado
	end
end

class Lagarto < Jugada

	def puntos(j)
		if j == "papel"
			resultado = [1,0]
		elsif j == "piedra"
			resultado = [0,1]
		elsif j == "tijeras"
			resultado = [0,1]
		elsif j == "spock"
			resultado = [1,0]
		elsif j == "lagarto"
			resultado = [0,0]
		else 
			raise "Movimiento invalido"
		end
		resultado
	end
end							