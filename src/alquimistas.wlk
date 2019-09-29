object alquimista{
	
	var items = []
	var itemsDeCombate = []
	var itemsDeRecoleccion = []
	
	method agregarItemDeRecoleccion(unItem){
		itemsDeRecoleccion.add(unItem)	
	}
	
	method sacarItemDeRecoleccion(unItem){
		itemsDeRecoleccion.remove(unItem)
	}
	
	method agregarItemDeCombate(unItem){
		itemsDeCombate.add(unItem)
	}
	method sacarItemDeCombate(unItem){
		itemsDeCombate.remove(unItem)
	}
//1
	method tieneCriterio(){
		return	self.cantidadEfectivos() >= self.cantidadItemsDeCombate() / 2
		}
	
	method cantidadItemsDeCombate(){
		return itemsDeCombate.size()
	}
	
	method cantidadEfectivos(){
		return itemsDeCombate.count({
			item=>item.esEfectivo()
			})
		}
//2
	method esBuenExplorador(){
		return self.cantidadItemsDeRecoleccion() >= 3
		}
	
	method cantidadItemsDeRecoleccion(){
		return itemsDeRecoleccion.asSet().size()
		}
//3
	method capacidadOfensiva(){
		return self.sumaCapacidades()
		}
	
	method sumaCapacidades(){
		return itemsDeCombate.sum({
			items => items.capacidad()
			})
}
//4
	method esProfesional(){
		return self.calidadPromedio() >= 50 and self.todosItemsEfectivos() and self.esBuenExplorador() 
		}
		
	method calidadPromedio(){
		return itemsDeCombate.sum({
			item => item.calidadItem()
			}) / self.cantidadItemsDeCombate()
		}
	
	method todosItemsEfectivos(){
		return itemsDeCombate.all({
			item => item.esEfectivo()
			})
		}
}

object bomba {
	var danio = 101 // Capacidad = 50.5
	var materiales = [uni, florRoja]
	
	method esEfectivo(){
		return danio > 100
		}
	method calidadItem(){
		return materiales.min({
			material => material.calidad()
		}).calidad()
	}
	method capacidad(){
		return danio/2
		}
}

object debilitador{
	var debilita = 20  // Capacidad = 5
	var materiales = [florRoja,florRoja,florRoja,florRoja]

	method esEfectivo(){
		return debilita > 0 and self.noTieneMistico()
		}
	method noTieneMistico(){
		return materiales.any({
			material => material.esMistico().negate()
			})
		}
	method capacidad(){
		if(self.noTieneMistico()){
			return 5
			}else{
				return  self.cantidadDeMisticos()*12
			}
		}
	method cantidadDeMisticos(){
		return materiales.count({
			material => material.esMistico()
		 })
		}
	method calidadItem(){
		return self.promedioDeLosDosMayores()
	}
	method promedioDeLosDosMayores(){
		return self.calidadDosMayores()/2
	}
	method calidadDosMayores(){
		return (self.dosMayores()).sum({
			material => material.calidad()
		})
	}
	
	method dosMayores() {
		return materiales.sortedBy({
			unMaterial, otroMaterial => unMaterial.calidad() > otroMaterial.calidad()
		}).take(2)
	}
}

object pocionNoEfectiva{ // Creada para el test
	var poderCurativo = 40
	var materiales = [florRoja]
	
	method esEfectivo(){
		return poderCurativo > 50 and self.tieneMaterialMistico()
	}
	method tieneMaterialMistico(){
		return materiales.any({material=>material.esMistico()})
	}
}

object pocion{ 
	var poderCurativo = 51 // Capacidad = 61
	var materiales = [florRoja,uni]

	method esEfectivo(){
		return poderCurativo > 50 and self.tieneMaterialMistico()
		}
		
	method calidadMateriales(){
		return materiales.sum({
			material => material.calidad()
			})
		}
		
	method tieneMaterialMistico(){
		return materiales.any({material=>material.esMistico()})
		}
		
	method capacidad(){
		return poderCurativo + 10 * self.cantidadMaterialesMisticos()
		}
		
	method cantidadMaterialesMisticos(){
		return materiales.count({
			material => material.esMistico()
			})
		}
		
	method calidadItem(){
		if(self.tieneMaterialMistico()){
			return self.primerMaterialMistico().calidad()
		}else{
			return materiales.first().calidad()
		}
	}
	
	method primerMaterialMistico() {
		return materiales.filter({
			material => material.esMistico()
		}).first()
	}
	
	method materiales(){
		return materiales
	}
}
object red{}

object cania{}

object bolsa {}

object florRoja{
	var calidad = 100 // Valor supuesto
	var mistico = false
	method esMistico(){
		return mistico 
		}
	method calidad(){
		return calidad
		}
}

object uni{
	var calidad = 50 // Valor supuesto
	var mistico = true
	method esMistico(){
		return mistico 
		}
	method calidad(){
		return calidad
		}
}
