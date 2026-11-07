# Programación con Objetos 1 UNAHUR - 2026C2


# Registro Nacional de Tierras Rurales

La Ley 26.737 de Tierras Rurales pone límites a la compra de tierras rurales por parte de extranjeros, y hoy su vigencia y alcance están en discusión. El Registro Nacional de Tierras Rurales necesita un módulo que permita simular, de forma simplificada, qué compras serían válidas bajo esas reglas.

## Tierras rurales

De cada tierra se conoce su nombre, su superficie (en hectáreas), su precio y la región en la que está ubicada. Además, se sabe si da a un cuerpo de agua permanente (un lago, una laguna, un río) y si está en zona de seguridad de frontera. Salvo que se indique lo contrario, una tierra no da a un cuerpo de agua ni es fronteriza.

Una tierra es **restringida** si da a un cuerpo de agua permanente o si es fronteriza.

Como no vale lo mismo una hectárea en cualquier lugar del país, la ley mide las tierras en cantidad de **hectáreas equivalentes**. La cantidad de **hectáreas equivalentes** dependen de la región:
* **Región núcleo:** la cantidad de **hectáreas equivalentes** es igual a toda su superficie
* **Región semiárida:** es la cuarta parte de su superficie
* **Región Patagonia:** es la décima parte de su superficie.

Por ejemplo, una tierra de 3000 hectáreas en la Patagonia tiene una cantidad de hectáreas equivalentes de 300.

## Compradores

Todo comprador tiene un presupuesto y conoce las tierras que posee (al principio, ninguna).

Cualquier comprador puede:
* Saber si puede comprar una tierra dada. En principio, puede hacerlo si su presupuesto alcanza para pagar el precio.
* Comprar una tierra. Si puede comprarla, el precio se descuenta de su presupuesto y la tierra pasa a ser suya. Si no puede, debe fallar lanzando el mensaje explicativo `"Compra no permitida"`.
* Saber la superficie total de sus tierras.
* Saber la cantidad total de hectáreas equivalentes de sus tierras.
* Saber cuántas hectáreas equivalentes tendría si comprara una tierra dada (las que ya tiene más las de la nueva tierra)
* Obtener una lista con los nombres de sus tierras restringidas.
* Dada una lista de tierras en venta, obtener las que puede comprar.
* Dada una lista de tierras en venta, comprar todas las que pueda.

## Tipos de compradores

### Persona argentina
* Puede comprar cualquier tierra que le alcance a pagar.

### Persona extranjera
Cuando el comprador es extranjero, además de que le alcance el presupuesto, la compra debe respetar los límites de la ley:
* No puede comprar tierras restringidas.
* La compra no puede hacerle exceder el límite de 1000 hectáreas equivalentes.

Cada vez que compra una tierra, además de lo que hace cualquier comprador, tramita un certificado de habilitación ante el Registro. Se quiere saber cuántos certificados tramitó.
### Empresa
* Conoce el porcentaje de su capital que está en manos extranjeras.
* Se la considera extranjera si ese porcentaje es mayor al 51%. Solo en ese caso debe respetar los límites para extranjeros.
* Si es extranjera, además de que le alcance el presupuesto, con la nueva tierra no puede superar su límite de hectáreas equivalentes, que es de 20 por cada punto de capital que no está en manos extranjeras. Por ejemplo, con 70% de capital extranjero su límite es de 600 hectáreas equivalentes.
* Puede recibir una inversión extranjera de un porcentaje dado, que se suma al porcentaje de capital extranjero que ya tiene (nunca puede superar el 100%).

## Test mínimos a realizar
* Dada una persona argentina con presupuesto suficiente, cuando quiere comprar una tierra que da a una laguna, entonces puede hacerlo.
* Dada una persona extranjera con presupuesto suficiente, cuando quiere comprar una tierra fronteriza, entonces no puede hacerlo.
* Dada una persona extranjera que ya posee 600 hectáreas en zona núcleo, entonces no puede comprar otras 500 hectáreas en zona núcleo, pero sí puede comprar 3000 hectáreas en la Patagonia.
* Dada una empresa con 40% de capital extranjero que ya posee 600 hectáreas en zona núcleo, puede comprar otras 500 hectáreas en zona núcleo, pero cuando recibe una inversión extranjera del 20%, entonces ya no puede.
* Dada una persona argentina con presupuesto 1000, cuando intenta comprar una tierra de precio 1200, entonces falla con el mensaje "Compra no permitida" y su presupuesto sigue siendo 1000.
* Dada una persona extranjera que compra dos tierras permitidas, entonces tramitó dos certificados de habilitación.