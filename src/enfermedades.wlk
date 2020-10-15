// Requerimiento:
// Hacer que una enfermedad infecciosa se reproduzca.
// malaria.reproducir()


class EnfermedadDeCelulas {
	var cantDeCelulasAmenazadas
	
	method cantDeCelulasAmenazadas() = cantDeCelulasAmenazadas

	method atenuar(dosis,persona){
		self.disminuirCelulas(dosis)
		if(cantDeCelulasAmenazadas == 0){
			persona.curarseDe(self)
		}
	}
	
	method disminuirCelulas(dosis) {
		cantDeCelulasAmenazadas =  (cantDeCelulasAmenazadas - 15 * dosis).max(0)
	}
	
}

class EnfermedadInfecciosa inherits EnfermedadDeCelulas {
	
	method producirEfecto(persona){
		persona.subirTemperatura(cantDeCelulasAmenazadas / 1000)
	}
	
	method reproducir() {
		cantDeCelulasAmenazadas = cantDeCelulasAmenazadas * 2
	}
	
	method esAgresiva(persona) {
		return cantDeCelulasAmenazadas > persona.cantidadDeCelulas() * 0.1
	}
		
}

class EnfermedadAutoinmune inherits EnfermedadDeCelulas {
	var cantVecesQueAfectoPersona = 0
	
	method producirEfecto(persona){
		persona.destruirCelulas(cantDeCelulasAmenazadas)
		cantVecesQueAfectoPersona++
	}
	
	method esAgresiva(persona) {
		return cantVecesQueAfectoPersona > 30
	}
	
}

object laHipotermia {
	method producirEfecto(persona){
		persona.disminuirTodaLaTemperatura()
	}
}

