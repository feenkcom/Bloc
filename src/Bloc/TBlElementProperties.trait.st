Trait {
	#name : #TBlElementProperties,
	#traits : 'TBlAlignable',
	#classTraits : 'TBlAlignable classTrait',
	#category : #'Bloc-Core-Properties'
}

{ #category : #adding }
TBlElementProperties >> addProperty: aBlElementProperty [
	self explicitRequirement
]

{ #category : #'api - properties' }
TBlElementProperties >> background: aPaint [
	self addProperty: (BlElementBackgroundProperty new background: aPaint)
]

{ #category : #'api - properties' }
TBlElementProperties >> border: aBlBorder [
	self addProperty: (BlElementBorderProperty new border: aBlBorder)
]

{ #category : #'api - properties constraints' }
TBlElementProperties >> constraintsDo: aBlock [
	self addProperty: (BlElementLayoutConstraintsProperty new constraintsBlock: aBlock)
]

{ #category : #'api - properties' }
TBlElementProperties >> do: anApplyBlock [
	"Perform a given block closure when a property is applied to an element"
	self do: anApplyBlock after: [  ]
]

{ #category : #'api - properties' }
TBlElementProperties >> do: anApplyBlock after: aCleanBlock [
	self addProperty: (BlElementDynamicProperty new
		applyAction: anApplyBlock;
		cleanAction: aCleanBlock)
]

{ #category : #'api - properties' }
TBlElementProperties >> effect: aBlEffect [
	self addProperty: (BlElementEffectProperty new effect: aBlEffect)
]

{ #category : #'api - properties font' }
TBlElementProperties >> fontSizeEm: aNumber [
	self fontSize: (BlValueWithUnit em: aNumber)
]

{ #category : #'api - properties font' }
TBlElementProperties >> fontSizePt: aNumber [
	self fontSize: (BlValueWithUnit pt: aNumber)
]

{ #category : #'api - properties font' }
TBlElementProperties >> fontSizeRem: aNumber [
	self fontSize: (BlValueWithUnit rem: aNumber)
]

{ #category : #'api - properties' }
TBlElementProperties >> foreground: aPaint [
	self addProperty: (BlElementForegroundProperty new foreground: aPaint)
]

{ #category : #'api - properties' }
TBlElementProperties >> geometry: aBlElementGeometry [
	self addProperty: (BlElementGeometryProperty new geometry: aBlElementGeometry)
]

{ #category : #'api - properties' }
TBlElementProperties >> gone [
	self visibility: BlVisibility gone
]

{ #category : #'api - properties' }
TBlElementProperties >> hidden [
	self visibility: BlVisibility hidden
]

{ #category : #accessing }
TBlElementProperties >> horizontalAlignment [
	self shouldNotImplement
]

{ #category : #'api - properties constraints' }
TBlElementProperties >> horizontalAlignment: anElementAlignment [
	self addProperty: (BlElementLayoutHorizontalAlignmentProperty new alignment: anElementAlignment)
]

{ #category : #'api - properties' }
TBlElementProperties >> layout: aBlLayout [
	self addProperty: (BlElementLayoutProperty new layout: aBlLayout)
]

{ #category : #'api - properties constraints' }
TBlElementProperties >> margin: aBlInsets [
	self addProperty: (BlElementMarginProperty new margin: aBlInsets)
]

{ #category : #'api - properties constraints' }
TBlElementProperties >> padding: aBlInsets [
	self addProperty: (BlElementPaddingProperty new padding: aBlInsets)
]

{ #category : #'api - properties' }
TBlElementProperties >> scaleBy: aNumber [
	self addProperty: (BlElementTransformationScaleProperty new scaleFactor: aNumber)
]

{ #category : #accessing }
TBlElementProperties >> verticalAlignment [	
	self shouldNotImplement
]

{ #category : #'api - properties constraints' }
TBlElementProperties >> verticalAlignment: anElementAlignment [
	self addProperty: (BlElementLayoutVerticalAlignmentProperty new alignment: anElementAlignment)
]

{ #category : #'api - properties' }
TBlElementProperties >> visibility: aBlVisibility [
	self addProperty: (BlElementVisibilityProperty new visibility: aBlVisibility)
]

{ #category : #'api - properties' }
TBlElementProperties >> visible [
	self visibility: BlVisibility visible
]
