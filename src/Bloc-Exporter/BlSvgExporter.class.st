"
I export bloc elements as SVG file.

```
| element |
element := BlElement new.
element background: Color red.
element geometry: BlEllipseGeometry new.
element size: 400@200.

(BlExporter svg element: element; fileName: 'test.svg'; export) inspect
```

"
Class {
	#name : #BlSvgExporter,
	#superclass : #BlFileExporter,
	#category : #'Bloc-Exporter'
}

{ #category : #'instance creation' }
BlSvgExporter >> createCanvas: anExtent [
	^ Bloc preferableSpartaCanvas svg: self fileName extent: anExtent
]

{ #category : #'instance creation' }
BlSvgExporter >> drawOn: aCanvas during: aBlock [
	| anSvgString |
	anSvgString := aCanvas drawDuring: [ :anSvgReadyCanvas |
		super drawOn: anSvgReadyCanvas during: aBlock ].

	^ anSvgString
]

{ #category : #'api - exporting' }
BlSvgExporter >> export [
	<return: #String>

	^ self doExport: [ :anSvgString |
		| aFileReference |
		aFileReference := self fileName asFileReference.
		aFileReference ensureDelete.
		aFileReference writeStreamDo: [ :s | s nextPutAll: anSvgString ]. 
		aFileReference ]
]

{ #category : #'api - exporting' }
BlSvgExporter >> extension [
	^ 'svg'
]
