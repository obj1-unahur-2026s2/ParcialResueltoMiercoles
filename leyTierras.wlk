class Tierra{
  var property nombre
  var property superficie
  var property precio
  var property region

  var property tieneAgua = false
  var property esFronterizo = false

  method esRestringida() = tieneAgua or esFronterizo

  method hectareasEquivalentes() = region.hectareasEquivalentes(superficie)
}

// es importante que existan estos objetos y que no se use un Else IF en Tierra. Porque asi evaluamos la programacion orientada a objetos
object zonaNucleo{
  method hectareasEquivalentes(superficie) = superficie
}
object zonaSemiArida{
  method hectareasEquivalentes(superficie) = superficie/4
}
object zonaPatagonia{
  method hectareasEquivalentes(superficie) = superficie/10
}

class Comprador{
  var property presupuesto
  const tierras=[]

  method puedeComprar(unaTierra)= presupuesto >= unaTierra.precio()

  method comprarTierra(unaTierra){
      if (self.puedeComprar(unaTierra)){
            presupuesto = presupuesto - unaTierra.precio()
            tierras.add(unaTierra)
      }
      else {
            throw new Exception(message = "Compra no permitida") // no es tan importante si hacen la excepcion porque no lo vimos mucho. Mientras tengan bien resuelto lo interno del if esta ok. solo pongamos el comentario de que falta esto 
      }
  }

  method superficieTotal() = tierras.sum({t => t.superficie()})

  method cantidadHectareasEquivalentes() = tierras.sum({t => t.hectareasEquivalentes()})

  method hectareasEquivalentesSiCompra(unaTierra) = (self.cantidadHectareasEquivalentes() + unaTierra.hectareasEquivalentes()) 

  method tierrasRestringidas()= tierras.filter({t => t.esRestringida()}).map({t => t.nombre()})

  method tierrasPuedeComprar(listaTierras) = listaTierras.filter({t => self.puedeComprar(t)}) 

  method comprarLista(listaTierras) =  listaTierras.forEach({t => if(self.puedeComprar(t))
                                                                      self.comprarTierra(t)
                                                                    })
  //No es la mejor opcion pero tambien se las tomamos como validas. Poner comentarios explicando que no es la correcta, pero no bajamos puntos si hacen esta opcion:
  //method comprarLista(listaTierras) =  self.tierrasPuedeComprar(listaTierras).forEach({t => self.comprarTierra(t)})
}

class Extranjero inherits Comprador{
  var property cantCertificado = 0

  override method puedeComprar(unaTierra){
    return super(unaTierra) && not unaTierra.esRestringida() 
              && self.hectareasEquivalentesSiCompra(unaTierra) <= 1000
  }

  override method comprarTierra(unaTierra){
    if (self.puedeComprar(unaTierra)){
        super(unaTierra)
        cantCertificado = cantCertificado + 1 //puede haber otras soluciones mientras se respete No repetir codigo. Lo general va en Comprador, y lo especifico en Extranjero
    }  else {
        throw new Exception(message = "Compra no permitida")
    }
  }

}

class Empresa inherits Comprador{
    var porcentajeCapitalExtranjero
    
    method esExtranjera() = porcentajeCapitalExtranjero > 51

    method recibirInversionExtranjera(porcentaje) {
      porcentajeCapitalExtranjero = (porcentajeCapitalExtranjero + porcentaje).min(100)
    }

    method limiteHectareasEquivalente() = (100 - porcentajeCapitalExtranjero) * 20

    //puede ser que el enunciado confunda cuando dice "Solo en ese caso debe respetar los límites para extranjeros."
    //y algunos creen que entonces debe aplicar todos los limites que tienen las personas extranjeras. si hacen eso no hay problema
    // la idea es que el parrafo siguiente indica que limites tiene una empresa extranjera, ese limite debe estar, pero si ademas agregar el de persona extranjera, no hay problema 
    override method puedeComprar(unaTierra){
       if (not self.esExtranjera())
          return super(unaTierra)
       else
          return super(unaTierra) && not unaTierra.esRestringida()  
              && self.hectareasEquivalentesSiCompra(unaTierra) <= self.limiteHectareasEquivalente() 
              //puede haber otras soluciones mientras se respete No repetir codigo. En este caso se repite solo "not unaTierra.esRestringida()" porque queda entendible y limpio  el codigo. pero puede haber soluciones diferentes mientras respeten POO , herencia, clases
    }
}

