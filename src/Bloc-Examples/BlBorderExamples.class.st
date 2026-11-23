"
# Border

Border is another essential visual property in addition to the {{gtClass:BlBackground}}. It is represented by {{gtClass:BlBorder}} which encapsulates various border properties such as paint, width, style and opacity.
**All border instances are immutable objects.**

The simplest way to create a border is to use Color.
{{gtExample:BlBorderExamples>>#colorGrayBorder}}
In addition users can provide a custom width along side with the paint, it is the most common way to create a border:
{{gtExample:BlBorderExamples>>#colorGrayBorderWithExplicitWidth}}

## Immutability

As it was mentioned previously the border is immutable. Any change to its state once created results in {{gtClass:BlImmutableObjectChangeError}}.
The reason for the border to be immutable is to simplify overall design, decrease complexity and prevent users from making trivial mistakes. Some border properties influence the geometry of the element (stroked bounds) which means that every time the border width is changed we should somehow notify and invalidate the element that uses that border. Either the user would have to send some invalidation message to the element or the border should know its element. If we make users be responsible for manual invalidation sooner or later it may happen that they forget or just will have a lack of understanding of such details therefore they will start to think that Bloc does not work properly. That is why a clean and nice solution is to make border immutable and enfore users to use {{gtMethod:BlElement>>#border:}} every time he or she wants to change the border.

In the following example we show what happens if user tries to change the width of the existing border:
{{gtExample:BlBorderExamples>>#changeWidthError}}
## Changing border's properties

The obvious downside of the immutability is the fact that it is not possible to mutate one specific border's property. To address this issue border provides a set of `copyWith*:` methods that create a new instance of the border with one one property modified.
Assume the following example in which we create a new border with a different width preserving all other properties:
{{gtExample:BlBorderExamples>>#copyWithWidth}}


"
Class {
	#name : #BlBorderExamples,
	#superclass : #Object,
	#category : #'Bloc-Examples-! Documentation examples'
}

{ #category : #examples }
BlBorderExamples >> borderRefreshesOnInheritedThemeChange [
	<gtExample>
	<return: #BlElement>
	| anOriginalTheme aColor aParent aChild |
	anOriginalTheme := BlTheme new.
	aColor := BlThemeableColor
			color: [ :aTheme | Color red ]
			source: [ :anotherTheme | Color blue ]
			forTheme: anOriginalTheme.
	aChild := BlTextElement new
			text: 'Border' asRopedText;
			border: (BlBorder paint: Color red width: 1);
			yourself.
	aParent := BlElement new
			theme: anOriginalTheme;
			addChild: aChild;
			yourself.
	aChild border: (BlBorder paint: aColor width: 1).
	self assert: aChild border paint color rawColor equals: Color red.
	aParent theme: BlTheme new.
	self assert: aChild border paint color equals: Color blue.
	^ aChild
]

{ #category : #examples }
BlBorderExamples >> borderRefreshesWhenThemeIsModified [
	<gtExample>
	<return: #BlScripter>
	| aTheme aColor anElement aScripter |
	aTheme := BlTheme new.
	aColor := BlThemeableColor
			color: [ :aCurrentTheme | Color red ]
			source: [ :aCurrentTheme | Color blue ]
			forTheme: aTheme.
	anElement := BlElement new
			theme: aTheme;
			size: 24 @ 24;
			border: (BlBorder paint: aColor width: 2);
			yourself.
	aScripter := BlScripter new element: anElement.
	self assert: anElement border paint color rawColor equals: Color red.
	aScripter
		doStep: [ :aStep | 
			aStep
				label: 'Modify the active theme';
				block: [ aTheme themeModified ] ].
	self assert: anElement border paint color equals: Color blue.
	^ aScripter
]

{ #category : #examples }
BlBorderExamples >> borderResolvesOnAssignment [
	<gtExample>
	<return: #BlElement>
	| aColor aBorder anElement |
	aColor := BlThemeableColor
			color: [ :aTheme | Color red ]
			source: [ :anotherTheme | Color blue ]
			forTheme: BlTheme new.
	aBorder := ((BlBorder paint: aColor width: 2)
			copyWithStyle: BlStrokeStyle dashed) copyWithOpacity: 0.5.
	anElement := BlElement new
			theme: BlTheme new;
			size: 24 @ 24;
			border: aBorder;
			yourself.
	self assert: anElement border paint color equals: Color blue.
	self assert: anElement border width equals: aBorder width.
	self assert: anElement border style equals: aBorder style.
	self assert: anElement border opacity equals: aBorder opacity.
	self assert: aBorder paint color rawColor equals: Color red.
	^ anElement
]

{ #category : #'examples - immutability' }
BlBorderExamples >> changeOpacityError [
	<gtExample>
	<return: #BlImmutableObjectChangeError>
	| aBorder anError |
	aBorder := self colorGrayBorder.

	[ aBorder opacity: 0.4 ]
		on: BlImmutableObjectChangeError
		do: [ :e | anError := e ].

	self assert: (anError isKindOf: BlImmutableObjectChangeError).

	^ anError
]

{ #category : #'examples - immutability' }
BlBorderExamples >> changePaintError [
	<gtExample>
	<return: #BlImmutableObjectChangeError>
	| aBorder anError |
	aBorder := self colorGrayBorder.

	[ aBorder paint: Color red ]
		on: BlImmutableObjectChangeError
		do: [ :e | anError := e ].

	self assert: (anError isKindOf: BlImmutableObjectChangeError).

	^ anError
]

{ #category : #'examples - immutability' }
BlBorderExamples >> changeStyleError [
	<gtExample>
	<return: #BlImmutableObjectChangeError>
	| aBorder anError |
	aBorder := self colorGrayBorder.

	[ aBorder style: BlStrokeStyle default ]
		on: BlImmutableObjectChangeError
		do: [ :e | anError := e ].

	self assert: (anError isKindOf: BlImmutableObjectChangeError).

	^ anError
]

{ #category : #'examples - immutability' }
BlBorderExamples >> changeWidthError [
	<gtExample>
	<return: #BlImmutableObjectChangeError>
	| aBorder anError |
	aBorder := self colorGrayBorder.

	[ aBorder width: 20 ]
		on: BlImmutableObjectChangeError
		do: [ :e | anError := e ].

	self assert: (anError isKindOf: BlImmutableObjectChangeError).

	^ anError
]

{ #category : #accessing }
BlBorderExamples >> colorAsBlBorder [
	<gtExample>
	<return: #BlBorderExamples>
	self assert: Color red asBlBorder = (BlBorder paint: Color red)
]

{ #category : #'examples - color' }
BlBorderExamples >> colorGrayBorder [
	<gtExample>
	<return: #BlBorder>
	| aBorder |
	aBorder := BlBorder paint: Color gray.

	self assert: (aBorder paint isKindOf: BlColorPaint).
	self assert: aBorder paint color equals: Color gray.

	self assert: (aBorder style isKindOf: BlStrokeStyle).
	self assert: aBorder style lineCap equals: BlStrokeLineCap butt.
	self assert: aBorder style lineJoin equals: BlStrokeLineJoin miter.
	self assert: aBorder style miterLimit equals: 4.0.
	self assert: aBorder style dashArray equals: #().
	self assert: aBorder style dashOffset equals: 0.0.

	self assert: aBorder width equals: 1.0.
	self assert: aBorder opacity equals: 1.0.

	^ aBorder
]

{ #category : #'examples - color' }
BlBorderExamples >> colorGrayBorderWithExplicitWidth [
	<gtExample>
	<return: #BlBorder>
	| aBorder |
	aBorder := BlBorder paint: Color gray width: 10.

	self assert: (aBorder paint isKindOf: BlColorPaint).
	self assert: aBorder paint color equals: Color gray.

	self assert: (aBorder style isKindOf: BlStrokeStyle).
	self assert: aBorder style lineCap equals: BlStrokeLineCap butt.
	self assert: aBorder style lineJoin equals: BlStrokeLineJoin miter.
	self assert: aBorder style miterLimit equals: 4.0.
	self assert: aBorder style dashArray equals: #().
	self assert: aBorder style dashOffset equals: 0.0.

	self assert: aBorder width equals: 10.
	self assert: aBorder opacity equals: 1.0.

	^ aBorder
]

{ #category : #examples }
BlBorderExamples >> concreteBorderReplacesMatchingThemeableBorder [
	<gtExample>
	<return: #BlElement>
	| aTheme aThemeableRed aFixedBorder anElement |
	aTheme := BlTheme new.
	aThemeableRed := BlThemeableColor
			color: [ :aCurrentTheme | Color red ]
			source: [ :anotherTheme | Color blue ]
			forTheme: aTheme.
	aFixedBorder := BlBorder paint: Color red width: 2.
	anElement := BlElement new
			theme: aTheme;
			size: 24 @ 24;
			border: (BlBorder paint: aThemeableRed width: 2);
			border: aFixedBorder halt;
			theme: BlTheme new;
			yourself.
	self assert: anElement border == aFixedBorder.
	^ anElement
]

{ #category : #'examples - copying' }
BlBorderExamples >> copyWithOpacity [
	<gtExample>
	<return: #BlBorder>
	| anOldBorder aBorder |
	anOldBorder := self colorGrayBorder.
	aBorder := anOldBorder copyWithOpacity: 0.5.

	self assert: (aBorder paint isKindOf: BlColorPaint).
	self assert: aBorder paint color equals: Color gray.

	self assert: (aBorder style isKindOf: BlStrokeStyle).
	self assert: aBorder style lineCap equals: BlStrokeLineCap butt.
	self assert: aBorder style lineJoin equals: BlStrokeLineJoin miter.
	self assert: aBorder style miterLimit equals: 4.0.
	self assert: aBorder style dashArray equals: #().
	self assert: aBorder style dashOffset equals: 0.0.

	self assert: aBorder width equals: 1.0.
	self assert: aBorder opacity equals: 0.5.

	^ aBorder
]

{ #category : #'examples - copying' }
BlBorderExamples >> copyWithPaint [
	<gtExample>
	<return: #BlBorder>
	| anOldBorder aBorder |
	anOldBorder := self colorGrayBorder.
	aBorder := anOldBorder copyWithPaint: Color blue.

	self assert: (aBorder paint isKindOf: BlColorPaint).
	self assert: aBorder paint color equals: Color blue.

	self assert: (aBorder style isKindOf: BlStrokeStyle).
	self assert: aBorder style lineCap equals: BlStrokeLineCap butt.
	self assert: aBorder style lineJoin equals: BlStrokeLineJoin miter.
	self assert: aBorder style miterLimit equals: 4.0.
	self assert: aBorder style dashArray equals: #().
	self assert: aBorder style dashOffset equals: 0.0.

	self assert: aBorder width equals: 1.0.
	self assert: aBorder opacity equals: 1.0.

	^ aBorder
]

{ #category : #'examples - copying' }
BlBorderExamples >> copyWithStyle [
	<gtExample>
	<return: #BlBorder>
	| anOldBorder aBorder |
	anOldBorder := self colorGrayBorder.
	aBorder := anOldBorder copyWithStyle: BlStrokeStyle dashed.

	self assert: (aBorder paint isKindOf: BlColorPaint).
	self assert: aBorder paint color equals: Color gray.

	self assert: (aBorder style isKindOf: BlStrokeStyle).
	self assert: aBorder style lineCap equals: BlStrokeLineCap butt.
	self assert: aBorder style lineJoin equals: BlStrokeLineJoin miter.
	self assert: aBorder style miterLimit equals: 4.0.
	self assert: aBorder style dashArray equals: #(6 4.2).
	self assert: aBorder style dashOffset equals: 0.0.

	self assert: aBorder width equals: 1.0.
	self assert: aBorder opacity equals: 1.0.

	^ aBorder
]

{ #category : #'examples - copying' }
BlBorderExamples >> copyWithWidth [
	<gtExample>
	<return: #BlBorder>
	| anOldBorder aBorder |
	anOldBorder := self colorGrayBorder.
	aBorder := anOldBorder copyWithWidth: 10.

	self assert: (aBorder paint isKindOf: BlColorPaint).
	self assert: aBorder paint color equals: Color gray.

	self assert: (aBorder style isKindOf: BlStrokeStyle).
	self assert: aBorder style lineCap equals: BlStrokeLineCap butt.
	self assert: aBorder style lineJoin equals: BlStrokeLineJoin miter.
	self assert: aBorder style miterLimit equals: 4.0.
	self assert: aBorder style dashArray equals: #().
	self assert: aBorder style dashOffset equals: 0.0.

	self assert: aBorder width equals: 10.
	self assert: aBorder opacity equals: 1.0.

	^ aBorder
]
