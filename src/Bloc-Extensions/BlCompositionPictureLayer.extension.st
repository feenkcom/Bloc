Extension { #name : #BlCompositionPictureLayer }

{ #category : #'*Bloc-Extensions' }
BlCompositionPictureLayer >> asElement [
	<return: #BlElement>
	| anElement |
	
	anElement := BlSpartaElement new
		size: self picture bounds extent;
		relocate: self picture bounds origin;
		rendering: [ :aCanvas :aSpartaElement |
			aSpartaElement userData
				at: #skiaLayer
				ifPresent: [ :aSkiaLayer | SkiaCompositor uniqueInstance draw: aSkiaLayer on: aCanvas ].

			self needsCache
				ifTrue: [ 
					aCanvas stroke
						path: aSpartaElement bounds inLocal asRectangle;
						paint: (Color gray alpha: 0.4);
						width: (self totalMatrix inverse transformX: 2.0 Y: 2.0) max;
						draw ]. ].

	anElement userData at: #skiaLayer put: self asSkiaLayer.
	^ anElement
]

{ #category : #'*Bloc-Extensions' }
BlCompositionPictureLayer >> asForm [
	^ self picture
		ifNil: [ Form extent: 0@0 depth: 32 ]
		ifNotNil: [ self picture asForm ]
]

{ #category : #'*Bloc-Extensions' }
BlCompositionPictureLayer >> gtExportAsSkpFor: anAction [
	<gtAction>

	^ anAction button
		tooltip: 'Export as .skp';
		icon: BrGlamorousVectorIcons clipboard;
		label: 'Export';
		action: [ :button |
			self picture ifNotNil: [ :aPicture |
				(self class name, '-', self identityHash asString, '.skp') asFileReference binaryWriteStream
					nextPutAll: aPicture asByteArray;
					flush ] ]
]

{ #category : #'*Bloc-Extensions' }
BlCompositionPictureLayer >> gtMatrixFor: aView [
	<gtView>
	^ aView forward
		title: 'Total matrix';
		priority: 6;
		object: [ self totalMatrix ];
		view: #gtMatrixFor:
]

{ #category : #'*Bloc-Extensions' }
BlCompositionPictureLayer >> gtPictureFor: aView [
	<gtView>
	^ aView explicit
		title: 'Picture';
		priority: 5;
		stencil: [ self asForm asElement ]
]
