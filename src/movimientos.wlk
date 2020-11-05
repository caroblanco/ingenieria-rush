import wollok.game.*
import players.*
import enemys.*
import disparos.*
import pantallaInicio.*

object config {
	const player = personajeSeleccionado.personaje() 
    method configurarTeclas() {
        keyboard.left().onPressDo({ 
           player.moveIzq()
        })
        keyboard.right().onPressDo({ 
            player.moveDer()
        })
        keyboard.up().onPressDo({ 
            elevator.paArriba()
        })
        keyboard.down().onPressDo({ 
            elevator.paAbajo()
        })
        keyboard.space().onPressDo({ 
            tirosPlayer.disparar()
        })
    }

    method configurarColisiones() {
        game.onCollideDo(player, {enemy => enemy.encuentro(player)})
    }
    method colisionDisparoPersonaje(){
        enemigos.listaEnemigos().forEach({enemy => game.onCollideDo(enemy, {tiro => tiro.encuentra(enemy,tiro)})})
    }
    method colisionDisparoEnemigo(tiro){
        game.onCollideDo(tiro,{jugador=>jugador.recibeDisparo(tiro)})
    }
}

object activador{
    method iniciar() {
        self.perseguirAPlayer()
        game.start()
        }
    method perseguirAPlayer(){
        game.onTick(800, "perseguir player", { perseguirPlayer.algo()}) //CAMBIAR NOMBRE DE "ALGO"
    }
    method disparosEnemigos(){
    	enemigos.listaEnemigosDisparo().forEach({enemy => enemy.disparar()})
    }
    method ontick(){
    	game.onTick(2000, "disparo enemigo", { self.disparosEnemigos()})
    }
}

object perseguirPlayer{
	const player = personajeSeleccionado.personaje()
	
    method algo(){enemigos.listaEnemigos().forEach({enemy => self.nuevaPosicion(enemy)})}
                                //puertas en x: 2-6-16-20 -> CONSTANTES
    method nuevaPosicion(enemy) {
         if(self.playerDistintoPiso(enemy)){
            self.irAlLimite(enemy)
        }else if(self.playerALaIzq(enemy)){
            self.movimientoDer(enemy)
        }else if(self.playerALaDer(enemy)){
            self.movimientoIzq(enemy)
        }
    }
    method movimientoDer(enemy){ 
        if (elevator.enElevator(player) && self.playerDistintoPiso(enemy) && enemy.position().x() == 9){
            self.irIzq(enemy)
        } else if (not self.playerDistintoPiso(enemy) || (self.playerDistintoPiso(enemy) && tablero.aLaIzqAscensor(enemy))){
            self.irDer(enemy)
        }
    }
    method movimientoIzq(enemy){
        if (elevator.enElevator(player) && self.playerDistintoPiso(enemy) && enemy.position().x() == 14){
            self.irDer(enemy)}
         else if (not self.playerDistintoPiso(enemy) || (self.playerDistintoPiso(enemy) && tablero.aLaDerAscensor(enemy))){
            self.irIzq(enemy)
        }
    }
    method playerALaIzq(enemy){
        return (enemy.position().x()<player.position().x())
    }
    method playerALaDer(enemy){
        return (enemy.position().x()>player.position().x())
    }
    method irIzq(enemy){
            enemy.move(enemy.position().left(1))
            enemy.nuevaDireccion(izquierda)
    }
    method irDer(enemy){
            enemy.move(enemy.position().right(1))
            enemy.nuevaDireccion(derecha)
    }
    method playerDistintoPiso(enemy){
        return (player.position().y() != enemy.position().y())
    }
    
    method irAlLimite(enemy){
        if (tablero.aLaIzqAscensor(enemy))
            self.irDer(enemy)
        else if (tablero.aLaDerAscensor(enemy))
            self.irIzq(enemy)
    }
}
