// Requerimientos:
// Hacer que una persona contraiga una enfermedad.
// frank.contraer(malariaPulenta)
// Hacer que una persona viva un día de su vida.
// logan.vivir()

class Persona {
	var temperatura = 36
	var cantidadDeCelulas = 3000000
	const property enfermedades = #{}
	
	method vivir() {
		enfermedades.forEach({enfermedad =>
			// Surtir el efecto de enfermedad en la persona
			enfermedad.producirEfecto(self)
		})
	}
	
	method contraer(enfermedad) {
		self.validarCantidadDeEnfermedades()
		enfermedades.add(enfermedad)
	}
	
	method validarCantidadDeEnfermedades() {
		if (enfermedades.size() >= 5) {
			self.error("La persona ya está llena de enfermedades")
		}
	}
	
	method tiene(enfermedad) = enfermedades.contains(enfermedad)
	
	method subirTemperatura(cantidad) {
		temperatura = 45.min(temperatura + cantidad)
	}
	
	method destruirCelulas(cantidad) {
		cantidadDeCelulas -= cantidad
	}
	
	method cantidadDeCelulas() = cantidadDeCelulas

	method cantidadDeCelulas(nuevaCantidadDeCelulas){
		cantidadDeCelulas = nuevaCantidadDeCelulas;
	}
	
	method temperatura() = temperatura
		
	method enfermedadesAgresivas() {
		return enfermedades.filter({ enfermedad => enfermedad.esAgresiva(self) })
	}
	
	method cantCelulasAmenazadasPorEnfermedadesAgresivas() {
		return self.enfermedadesAgresivas().sum({ enfermedad => enfermedad.cantDeCelulasAmenazadas() })
	}

	method enfermedadQueAmenazaMasCelulas() {
		enfermedades.max({ enfermedad => enfermedad.cantDeCelulasAmenazadas()})
	}
	
	method estaEnComa() {
		return temperatura == 45 || cantidadDeCelulas < 1000000
	}
	
	method curarseDe(enfermedad){
		enfermedades.remove(enfermedad)
	}
	
	method recibirMedicamento(dosis){
		enfermedades
			.forEach({enfermedad => enfermedad.atenuar(dosis,self)})
	}
	
	method disminuirTodaLaTemperatura(){
		temperatura = 0
	}
}

class Medico inherits Persona{
	const dosis
	
	method atender(persona){
		persona.recibirMedicamento(dosis)
	}
	
	override method contraer(enfermedad) {
		super(enfermedad)
		self.atender(self)
	}		

}

class JefeDepartamento inherits Medico{
	const subordinados = #{}
	
	override method atender(persona){
		subordinados.anyOne().atender(persona)
	}
}



