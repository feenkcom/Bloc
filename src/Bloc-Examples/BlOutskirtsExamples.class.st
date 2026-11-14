"
Rendering examples for borders drawn directly on paths. They check border placement and preservation of existing canvas content.
"
Class {
	#name : #BlOutskirtsExamples,
	#superclass : #Object,
	#category : #'Bloc-Examples-Basic'
}

{ #category : #private }
BlOutskirtsExamples >> borderMatchesDirectPathWith: anOutskirts [
	| element expected actual |
	element := BlElement new
			geometry: (BlRoundedRectangleGeometry cornerRadius: 16);
			border: (BlBorder paint: Color red width: 4);
			outskirts: anOutskirts;
			yourself.
	element geometry matchExtent: 64 @ 64.	"Leave room around the shape for an outside border."
	expected := BlSpartaRenderer defaultCanvasBuilder class extent: 96 @ 96.
	actual := BlSpartaRenderer defaultCanvasBuilder class extent: 96 @ 96.
	{expected.
		actual}
		do: [ :canvas | 
			canvas fill
				paint: Color blue;
				path: canvas bounds;
				draw ].	"Draw the border directly on its path."
	expected transform
		by: [ :transform | transform translateBy: 16 @ 16 ]
		during: [ element outskirts
				drawBorder: element border
				path: (element geometry pathOnSpartaCanvas: expected of: element)
				onSpartaCanvas: expected ].	"The element drawing entry point should produce the same pixels."
	actual transform
		by: [ :transform | transform translateBy: 16 @ 16 ]
		during: [ element outskirts
				drawBackground: [  ]
				border: [ element border drawOnSpartaCanvas: actual of: element ]
				of: element
				onSpartaCanvas: actual ].
	self assert: actual asForm bits equals: expected asForm bits.
	^ actual
]

{ #category : #private }
BlOutskirtsExamples >> canvasWithOutskirts: anOutskirts [
	| canvas path |
	canvas := BlSpartaRenderer defaultCanvasBuilder class extent: 64 @ 64.
	canvas fill
		paint: Color blue;
		path: canvas bounds;
		draw.
	path := canvas path
			absolute;
			moveTo: 20 @ 20;
			lineTo: 44 @ 20;
			lineTo: 44 @ 44;
			lineTo: 20 @ 44;
			close;
			finish.
	anOutskirts
		drawBorder: (BlBorder paint: Color red width: 4)
		path: path
		onSpartaCanvas: canvas.
	^ canvas
]

{ #category : #examples }
BlOutskirtsExamples >> centeredBorderMatchesDirectPath [
	<gtExample>
	<return: #SpartaCanvas>
	^ self borderMatchesDirectPathWith: BlOutskirts centered
]

{ #category : #examples }
BlOutskirtsExamples >> centeredPath [
	<gtExample>
	<return: #SpartaCanvas>
	| canvas form |
	canvas := self canvasWithOutskirts: BlOutskirts centered.
	form := canvas asForm.
	self assert: (form colorAt: 17 @ 30) equals: Color blue.
	self assert: (form colorAt: 19 @ 30) equals: Color red.
	self assert: (form colorAt: 21 @ 30) equals: Color red.
	self assert: (form colorAt: 23 @ 30) equals: Color blue.
	self assert: (form colorAt: 30 @ 30) equals: Color blue.
	^ canvas
]

{ #category : #examples }
BlOutskirtsExamples >> insideBorderMatchesDirectPath [
	<gtExample>
	<return: #SpartaCanvas>
	^ self borderMatchesDirectPathWith: BlOutskirts inside
]

{ #category : #examples }
BlOutskirtsExamples >> insidePath [
	<gtExample>
	<return: #SpartaCanvas>
	| canvas form |
	canvas := self canvasWithOutskirts: BlOutskirts inside.
	form := canvas asForm.
	self assert: (form colorAt: 18 @ 30) equals: Color blue.
	self assert: (form colorAt: 22 @ 30) equals: Color red.
	self assert: (form colorAt: 30 @ 30) equals: Color blue.
	^ canvas
]

{ #category : #examples }
BlOutskirtsExamples >> outsideBorderMatchesDirectPath [
	<gtExample>
	<return: #SpartaCanvas>
	^ self borderMatchesDirectPathWith: BlOutskirts outside
]

{ #category : #examples }
BlOutskirtsExamples >> outsidePath [
	<gtExample>
	<return: #SpartaCanvas>
	| canvas form |
	canvas := self canvasWithOutskirts: BlOutskirts outside.
	form := canvas asForm.
	self assert: (form colorAt: 15 @ 30) equals: Color blue.
	self assert: (form colorAt: 18 @ 30) equals: Color red.
	self assert: (form colorAt: 22 @ 30) equals: Color blue.
	self assert: (form colorAt: 30 @ 30) equals: Color blue.
	^ canvas
]
