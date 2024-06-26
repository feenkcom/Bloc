Extension { #name : #BlElement }

{ #category : #'*Bloc-Compositor' }
BlElement >> compositionDepth [
	<return: #Number>
	| aDepth |

	aDepth := 1.
	self allParentsDo: [ :eachParent | aDepth := aDepth + 1 ].
	^ aDepth
]

{ #category : #'*Bloc-Compositor' }
BlElement >> fullPaintCompositedOn: aCompositorPainter offset: anOffset [
	<argument: #anOffset satisfies: #isSpartaScalarPoint>
	| aLayer |

	self shouldBePainted
		ifTrue: [ BlCompositionPainter repaintCompositedElement: self ].

	aCompositorPainter stopRecording.

	aLayer := self compositionLayer.
	aLayer offset: anOffset.
	
	self assert: [ aLayer isKindOf: BlCompositionOffsetLayer ].
	
	aCompositorPainter addLayer: aLayer
]

{ #category : #'*Bloc-Compositor' }
BlElement >> fullPaintOn: aCompositorPainter offset: anOffset [
	"invisible elements are not rendered too"
	<argument: #anOffset satisfies: #isSpartaScalarPoint>

	"We do not draw transparent elements at all"
	self isTransparent
		ifTrue: [
			self markDoesNotNeedPaint.
			^ self ].
	
	self isVisible
		ifFalse: [
			self markDoesNotNeedPaint.
			^ self ].

	self invalidationBounds hasPositiveExtent
		ifFalse: [
			self markDoesNotNeedPaint.
			^ self ].

	self wantsSeparateCompositingLayer
		ifTrue: [
			self
				fullPaintCompositedOn: aCompositorPainter
				offset: anOffset + self position ]
		ifFalse: [
			self
				fullPaintWithTransformOn: aCompositorPainter
				offset: anOffset + self position ].

	self markDoesNotNeedPaint
]

{ #category : #'*Bloc-Compositor' }
BlElement >> fullPaintWithTransformOn: aCompositorPainter offset: anOffset [
	<argument: #anOffset satisfies: #isSpartaScalarPoint>

	self transformation isIdentity
		ifTrue: [ self paintMeAndChildrenWithOpacityOn: aCompositorPainter offset: anOffset ]
		ifFalse: [
			aCompositorPainter
				pushTransform: self transformation matrix
				offset: anOffset
				bounds: self invalidationBounds
				compositing: self compositingMode
				thenPaint: [ :aTransformCompositorPainter :aTransformOffset |
					self paintMeAndChildrenWithOpacityOn: aTransformCompositorPainter offset: aTransformOffset ] ]
]

{ #category : #'*Bloc-Compositor' }
BlElement >> hasCompositionLayer [
	<return: #Boolean>

	^ self compositionLayer isNotNil and: [ self compositionLayer isValid ]
]

{ #category : #'*Bloc-Compositor' }
BlElement >> paintChildrenOn: aCompositorPainter offset: anOffset [
	aCompositorPainter
		pushChildren: self children sortedByElevation
		offset: anOffset
		compositing: self compositingMode
		thenPaint: [ :aChildElement :aChildPainter :aChildOffset |
			aChildElement fullPaintOn: aChildPainter offset: aChildOffset ]
]

{ #category : #'*Bloc-Compositor' }
BlElement >> paintClippedChildrenOn: aCompositorPainter offset: anOffset [
	<argument: #anOffset satisfies: #isSpartaScalarPoint>

	"no need to draw and clip if there are no children "
	self hasChildren
		ifFalse: [ ^ self ].

	self clipChildren
		ifTrue: [ aCompositorPainter
			pushClip: (self geometry pathOnSpartaCanvas: aCompositorPainter canvas of: self)
			offset: anOffset
			bounds: self invalidationBounds
			compositing: self compositingMode
			thenPaint: [ :aClippedPainter :aClippedOffset | self paintChildrenOn: aClippedPainter offset: aClippedOffset ] ]
		ifFalse: [ self paintChildrenOn: aCompositorPainter offset: anOffset ]
]

{ #category : #'*Bloc-Compositor' }
BlElement >> paintMeAndChildrenOn: aCompositorPainter offset: anOffset [
	<argument: #anOffset satisfies: #isSpartaScalarPoint>

	self errorHandler
		with: self
		do: [ self paintOn: aCompositorPainter offset: anOffset. ]
		failed: [ :anError |
			aCompositorPainter canvas fill
				paint: Color lightGray;
				path: self boundsInLocal;
				draw ].

	self
		paintClippedChildrenOn: aCompositorPainter
		offset: anOffset
]

{ #category : #'*Bloc-Compositor' }
BlElement >> paintMeAndChildrenWithOpacityOn: aCompositorPainter offset: anOffset [
	<argument: #anOffset satisfies: #isSpartaScalarPoint>

	(self opacity closeTo: 1.0)
		ifTrue: [ self paintMeAndChildrenOn: aCompositorPainter offset: anOffset ]
		ifFalse: [
			aCompositorPainter
				pushOpacity: self opacity
				offset: anOffset
				bounds: self invalidationBounds
				compositing: self compositingMode
				thenPaint: [ :anOpacityPainter :anOpacityOffset | self paintMeAndChildrenOn: anOpacityPainter offset: anOpacityOffset ] ]
]

{ #category : #'*Bloc-Compositor' }
BlElement >> paintOn: aCompositorPainter offset: anOffset [
	| isOriginal |

	"For performance reasons we would like to limit amount of access
	to the painter's canvas. To do so we detect before-hand if there is anything
	we need to draw using #shouldDrawBackgroundOrBorder, however this only works
	if #drawOnSpartaCanvas: is not overriden (=is original)"
	isOriginal := (self class == BlElement) or: [  
		self class classAndMethodFor: #drawOnSpartaCanvas:
			do: [ :aClass :m | aClass == BlElement ]
			ifAbsent: [ true ] ].

	(isOriginal and: [ self shouldDrawBackgroundOrBorder not and: [ self effect isNullEffect ] ])
		ifTrue: [ ^ self ].

	self effect
		paintOn: aCompositorPainter
		offset: anOffset
		for: self
		thenPaint: [ :anEffectPainter :anEffectOffset |
			| aCanvas |
			aCanvas := anEffectPainter canvas.
			aCanvas transform
				by: [ :t | t translateBy: anEffectOffset ]
				during: [ self drawOnSpartaCanvas: aCanvas ] ]
]

{ #category : #'*Bloc-Compositor' }
BlElement >> shouldBePainted [
	<return: #Boolean>

	^ self needsPaint or: [ self hasCompositionLayer not ]
]
