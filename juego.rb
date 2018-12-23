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

class Estrategia
	attr_accessor :nombre, :patron

	def prox(m)
		if m.jugada == "papel"
			@patron = Papel.new("papel")
		elsif m.jugada == "piedra"
			@patron = Piedra.new("piedra")
		elsif m.jugada == "tijeras"
			@patron = Tijeras.new("tijeras")
		elsif m.jugada == "spock"
			@patron = Spock.new("spock")
		elsif m.jugada == "lagarto"
			@patron = Lagarto.new("lagarto")
		else
			raise "Error"
		end
		@patron				
	end

	def to_s
		s = "El jugador " + @nombre + "con la jugada " + @patron.to_s
	end

	def reset

	end		
end		


class Manual < Estrategia

	def get_jugada
		j1 = gets
		j1 = j1.chomp
		x1 = Jugada.new(j1)
		prox(x1)
	end


	
end									