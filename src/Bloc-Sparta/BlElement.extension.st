Extension { #name : #BlElement }

{ #category : #'*Bloc-Sparta' }
BlElement >> asSpartaForm [
	| aCanvas aBoundsInLocal |

	self isLayoutRequested
		ifTrue: [ self forceLayout ].

	aBoundsInLocal := (self effectBounds: BlBounds new)
		merge: self boundsInLocal;
		merge: self visualBounds.

	aCanvas := Bloc preferableSpartaCanvas extent: aBoundsInLocal extent ceiling.
	
	aCanvas transform
		by: [ :aTransform | aTransform translateBy: aBoundsInLocal origin negated ]
		during: [ self drawMeAndChildrenOnSpartaCanvas: aCanvas	 ].

	^ aCanvas asForm
]

{ #category : #'*Bloc-Sparta' }
BlElement >> asSpartaForm: preferredExtentOrNil scaleFactor: preferredScaleFactorOrNil hdpiScaleFactor: hdpiScaleFactor [
	"Render this element 'as-is' on a preferable sparta canvas backed by a pixel buffer.
	Must only be called from a UI process"
	| anElementExtent aScaleFactor aCanvas aSnapshot isZeroExtent |

	anElementExtent := self extent.
	isZeroExtent := (anElementExtent x closeTo: 0) or: [ anElementExtent y closeTo: 0 ].

	aScaleFactor := hdpiScaleFactor.
	isZeroExtent ifFalse: [ preferredExtentOrNil ifNotNil: [ :aPreferredExtent | aScaleFactor := aScaleFactor * (aPreferredExtent / anElementExtent) min ] ].
	preferredScaleFactorOrNil ifNotNil: [ :aPreferredScaleFactor | aScaleFactor := aScaleFactor * aPreferredScaleFactor ].

	aCanvas := Bloc preferableSpartaCanvas extent: ((anElementExtent  * aScaleFactor) asIntegerPoint max: 1@1).

	aCanvas fill
		path: aCanvas bounds;
		paint: Color white;
		draw.

	aCanvas transform
		by: [ :t | t scaleBy: aScaleFactor ]
		during: [ self drawMeWithEffectsOnCanvas: aCanvas ].

	aSnapshot := aCanvas asForm.

	^ BlScaledForm form: aSnapshot scaleFactor: hdpiScaleFactor
]

{ #category : #'*Bloc-Sparta' }
BlElement >> drawChildrenOnSpartaCanvas: aCanvas [

	"If there are not children no need to draw and clip"
	self hasChildren
		ifFalse: [ ^ self ].

	aCanvas clip
		when: [ self clipChildren ]
		by: [ self geometry pathOnSpartaCanvas: aCanvas of: self ]
		during: [ self children sortedByElevation
			do: [ :anElement | anElement fullDrawOnSpartaCanvas: aCanvas ] ]
]

{ #category : #'*Bloc-Sparta' }
BlElement >> drawError: anError onSpartaCanvas: aCanvas [

	aCanvas fill
		paint: Color lightGray;
		path: self boundsInLocal;
		draw.

	self drawChildrenOnSpartaCanvas: aCanvas
]

{ #category : #'*Bloc-Sparta' }
BlElement >> drawMeAndChildrenOnSpartaCanvas: aCanvas [
	self drawOnSpartaCanvas: aCanvas.
	self drawChildrenOnSpartaCanvas: aCanvas
]

{ #category : #'*Bloc-Sparta' }
BlElement >> drawMeWithEffectsOnCanvas: aCanvas [
	self effect
		applyEffectOnSpartaCanvas: aCanvas
		for: self
		around: [ :aShadowCanvas | self drawMeAndChildrenOnSpartaCanvas: aShadowCanvas ]
]

{ #category : #'*Bloc-Sparta' }
BlElement >> drawOnSpartaCanvas: aCanvas [	
	self shouldDrawBackgroundOrBorder
		ifFalse: [ ^ self ].

	aCanvas figure
		path: (self geometry pathOnSpartaCanvas: aCanvas of: self);
		background: self background;
		backgroundAlpha: self background opacity;
		border: self border paint;
		borderAlpha: self border opacity;
		width: self border width;
		in: [ :aPainter | self border style applyOn: aPainter ];
		in: [ :aPainter |
			self outskirts = BlOutskirts outside
				ifTrue: [ aPainter borderOutside ].
			self outskirts = BlOutskirts centered
				ifTrue: [ aPainter borderCentered ].
			self outskirts = BlOutskirts inside
				ifTrue: [ aPainter borderInside ] ];
		draw
]

{ #category : #'*Bloc-Sparta' }
BlElement >> fullDrawOnSpartaCanvas: aCanvas [
	flags clearNeedsPaint.

	"We do not draw transparent elements at all"
	self isTransparent
		ifTrue: [ ^ self ].

	"invisible elements are not rendered too"
	self isVisible
		ifFalse: [ ^ self ].

	aCanvas layer
		alpha: self opacity;
		when: [ self isTranslucent ]
		during: [
			aCanvas transform
				by: self transformation matrix
				translated: self position
				during: [ :aTransformedCanvas |
					self errorHandler
						with: self
						do: [ self drawMeWithEffectsOnCanvas: aCanvas ]
						failed: [ :anError | self drawError: anError onSpartaCanvas: aCanvas ] ] ]
]

{ #category : #'*Bloc-Sparta' }
BlElement >> shouldDrawBackgroundOrBorder [
	"I determine if background or border should be drawn.
	In its current form we just check if any of them are transparent"
	<return: #Boolean>
	| isBackgroundTransparent isBorderTransparent areBothTransparent |
	
	isBackgroundTransparent := self background isTransparent.
	isBorderTransparent := self border isTransparent.
	areBothTransparent := isBackgroundTransparent and: [ isBorderTransparent ].
	
	^ areBothTransparent not
]
