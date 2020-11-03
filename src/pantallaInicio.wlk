import wollok.game.*
import players.*
import movimientos.*
import enemys.*
import disparos.*

object configurarJuego{
    method empezar(seleccionado){
        game.addVisual(elevator)
        game.addVisual(seleccionado)
        enemigos.aparecerEnemigos()
        game.showAttributes(seleccionado)
        game.showAttributes(elevator)
        tirosPlayer.nuevaPosition()
        tirosEnemigo.nuevaPosition()
        config.configurarColisiones()
    }
}

object teclas{
	var teclas = seleccionador
	
	method cambiarTeclas(){
		teclas = config
	}
	
	method activarTeclas(){
		teclas.configurarTeclas()
	}
}

object inicio{
	method position() = game.at(0,2)
	method image(){
		return "aulamagna.png"
	}
}

object seleccionador{
	
	method configurarTeclas(){
	keyboard.left().onPressDo({ 
           nombreADefinir.cambiarPesonajeAColor(nombreADefinir.personajeAColor().aLaIzq())
        })
    keyboard.right().onPressDo({ 
           nombreADefinir.cambiarPesonajeAColor(nombreADefinir.personajeAColor().aLaDer())
        })
    keyboard.enter().onPressDo({
	    	game.removeVisual(inicio)
	    	personajeSeleccionado.cambiarP(nombreADefinir.personajeAColor().seleccionado()) 
	    	teclas.cambiarTeclas()
	    	teclas.activarTeclas()
	    	configurarJuego.empezar(nombreADefinir.personajeAColor().seleccionado())
	    	game.removeVisual(caroAElegir)
	    	game.removeVisual(camiAElegir)
	    	game.removeVisual(franAElegir)
    	})
    }
}

object nombreADefinir{
	var personajeAColor =caroAElegir
	method personajeAColor() = personajeAColor
	
	method cambiarPesonajeAColor(nuevoP){
		personajeAColor = nuevoP
	}

}

///////////////////////////////////////////////////////////////////

object camiAElegir{
	method position() = game.at(8,9)
	method aLaIzq() = franAElegir
	method aLaDer() = caroAElegir
	method seleccionado() = cami
	
	method image(){
		if(nombreADefinir.personajeAColor() == self){
			return "cami-der.png"
		}else{
			return "camiBYN.png"
		}
	}
}

object caroAElegir{
	method position() = game.at(12,9)
	method aLaIzq() = camiAElegir
	method aLaDer() = franAElegir
	method seleccionado() = caro
	method image(){
		if(nombreADefinir.personajeAColor() == self){
			return "caro-der.png"
		}else{
			return "caroBYN.png"
		}
	}
}

object franAElegir{
	method position() = game.at(16,9)
	method aLaIzq() = caroAElegir
	method aLaDer() = camiAElegir
	method seleccionado() = fran
	method image(){
		if(nombreADefinir.personajeAColor() == self){
			return "fran-der.png"
		}else{
			return "franBYN.png"
		}
	}
}

object personajeSeleccionado{
	var personaje
	method personaje() = personaje
	
	method cambiarP(nuevoP){
		personaje = nuevoP
	}
	
}