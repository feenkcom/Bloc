"
# Geometry, Visual, and Layout Bounds Explained

A bound is a territorial limit, a boundary. In terms of a graphical element, it is a space in which the graphical element is rendered. For simplicity, bounds are rectangular areas. Bloc defines three different bounds (layout, geometry, and visual) that we will explain using the following example:

{{gtExample:BlGeometryVisualAndLayoutBoundsExamples>>#centeredOutskirts|previewExpanded}}

""Layout"" bounds are drawn with gray dashed rectangles in the figure above. They are of this size in this particula example, because each element defines its size explicitly using `size:` method. Layout bounds are considered by layout algorithms to define mutual locations for all considered elements.

""Geometry"" bounds are drawn with red dashed rectangles in the figure above. The area is defined by minimum and maximum values of a polygon vertices. In case of rectangle, geometry bounds are defined by the following polygon:

{{gtExample:BlGeometryVisualAndLayoutBoundsExamples>>#rectanglePolygon}}

""Visual"" bounds are drawn with blue rectangles in the figure above. It is an exact area occupied by an element. Computing visual bounds is the most expensive computation as it takes strokes and rendering into account.

## Different Bounds Setups

The first figure above draws all strokes centered around the defined vertices. For that reason, the geometry bounds are in the middle. The following example draws strokes outside:

{{gtExample:BlGeometryVisualAndLayoutBoundsExamples>>#outsideOutskirts|previewExpanded}}

In case of the rectangle, you can notice that its stroke is inside of the visual (blue, outside) and the geometry (red, inside) bounds. If the strokes are drawn inside, then visual and geometry bounds are equal:

{{gtExample:BlGeometryVisualAndLayoutBoundsExamples>>#insideOutskirts|previewExpanded}}

## Clipping

Geometry is used to define clipping. Consider the below an example in which the triangle is placed in the green parent. When clipping is `false`, the triangle is seen in its entirety.

{{gtExample:BlGeometryVisualAndLayoutBoundsExamples>>#unclippedTriangle|previewExpanded=}}

When clipping is true, the triangle is cut.

{{gtExample:BlGeometryVisualAndLayoutBoundsExamples>>#clippedTriangle|previewExpanded=}}


# Debugging Bounds

Being able to display those three bounds helps when elements are not visually aligned as expected. Consider the following example:

{{gtExample:BlGeometryVisualAndLayoutBoundsExamples>>#misalignedIcon|previewExpanded}}

The triangle (icon) and text are not vertically centered despide the fact that we have `BlLinearLayout horizontal alignCenter` in the code. To understand why it happens, `aTriangleElement debug: true` can be added to the code with the following result:

{{gtExample:BlGeometryVisualAndLayoutBoundsExamples>>#debuggingMisalignedIcon|previewExpanded}}

As we can see the layout bounds (gray dashed rectangle) consider larger area then expected. Looking at the definition of the triangle polygon, we can spot that the polygon starts at `0@3` instead of `0@0`: 

{{gtExample:BlGeometryVisualAndLayoutBoundsExamples>>#misalignedTrianglePolygon}}

If we fix it to: 

{{gtExample:BlGeometryVisualAndLayoutBoundsExamples>>#trianglePolygon}}

The icon and text are aligned as expected:

{{gtExample:BlGeometryVisualAndLayoutBoundsExamples>>#debuggingAlignedIcon|previewExpanded}}

And we can disactivate the debug mode:

{{gtExample:BlGeometryVisualAndLayoutBoundsExamples>>#alignedIcon|previewExpanded}}

The debugging mode is also possible to activate in the GT-Inspector's menu, next to the tabs.

"
Class {
	#name : #BlGeometryVisualAndLayoutBoundsExamples,
	#superclass : #Object,
	#traits : 'TBlExample',
	#classTraits : 'TBlExample classTrait',
	#category : #'Bloc-Examples-Basic'
}

{ #category : #'debugging triangle and text' }
BlGeometryVisualAndLayoutBoundsExamples >> alignedIcon [
	<gtExample>
	<return: #BlElement>
	| anIconElement aLabelElement aContainerElement |
	anIconElement := self emptyIconElement geometry: self trianglePolygon.
	aLabelElement := self textElementWithRunText.
	aContainerElement := self iconAndTextContainer.
	aContainerElement
		addChildren: {anIconElement.
				aLabelElement}.
	^ aContainerElement
]

{ #category : #'rectangle and start' }
BlGeometryVisualAndLayoutBoundsExamples >> centeredOutskirts [
	<gtExample>
	<label: 'Rectangle and star elements with centered stroke'>
	<return: #BlElement>
	| aContainer |
	aContainer := self container.
	aContainer addChild: self rectangleWithSmallerGeometryCentered.
	aContainer addChild: self starWithSmallerGeometryCentered.

	^ aContainer
]

{ #category : #bounds }
BlGeometryVisualAndLayoutBoundsExamples >> clippedTriangle [
	<gtExample>
	<label: 'Clipped triangle polygon with layount bounds'>
	<return: #BlElement>
	| aContainer |
	aContainer := self unclippedTriangle.
	aContainer clipChildren: true.
	^ aContainer
]

{ #category : #'rectangle and start' }
BlGeometryVisualAndLayoutBoundsExamples >> container [
	<gtExample>
	<label: 'A container for the rectangle and the star'>
	<return: #BlElement>
	| aContainer |
	aContainer := BlElement new.
	aContainer layout: (BlGridLayout horizontal cellSpacing: 20).
	aContainer margin: (BlInsets all: 10).
	aContainer padding: (BlInsets all: 10).
	aContainer
		constraintsDo: [ :c | 
			c horizontal fitContent.
			c vertical fitContent ].
	^ aContainer
]

{ #category : #'debugging triangle and text' }
BlGeometryVisualAndLayoutBoundsExamples >> debuggingAlignedIcon [
	<gtExample>
	<return: #BlElement>
	| aContainerElement |
	aContainerElement := self alignedIcon.
	^ aContainerElement
]

{ #category : #'debugging triangle and text' }
BlGeometryVisualAndLayoutBoundsExamples >> debuggingMisalignedIcon [
	<gtExample>
	<return: #BlElement>
	| aContainerElement |
	aContainerElement := self misalignedIcon.
	aContainerElement children first.
	^ aContainerElement
]

{ #category : #bounds }
BlGeometryVisualAndLayoutBoundsExamples >> debuggingMode [
	<gtExample>
	<label: 'Triangle polygon with visual and geometry bounds'>
	<return: #BlElement>
	| aContainer |
	aContainer := self fullyVisibleTriangle.
	^ aContainer
]

{ #category : #'debugging triangle and text' }
BlGeometryVisualAndLayoutBoundsExamples >> emptyIconElement [
	<gtExample>
	<return: #BlDevElement>
	^ BlDevElement new
		size: 8 @ 12;
		background: Color green muchDarker
]

{ #category : #bounds }
BlGeometryVisualAndLayoutBoundsExamples >> fullyVisibleTriangle [
	<gtExample>
	<label: 'Fully visible triangle polygon that exceeds layout bounds'>
	<return: #BlElement>
	| aContainer |
	aContainer := self clippedTriangle.
	aContainer clipChildren: false.
	aContainer relocate: 30 @ 30.
	^ aContainer
]

{ #category : #'debugging triangle and text' }
BlGeometryVisualAndLayoutBoundsExamples >> iconAndTextContainer [
	<gtExample>
	<return: #BlElement>
	| aContainerElement |
	aContainerElement := BlElement new
			layout: BlLinearLayout horizontal alignCenter;
			constraintsDo: [ :c | 
				c horizontal fitContent.
				c vertical fitContent ];
			background: (Color gray alpha: 0.3);
			padding: (BlInsets all: 3);
			margin: (BlInsets left: 5).
	aContainerElement
		transformDo: [ :t | 
			t origin: BlAffineTransformationTopLeftOrigin new.
			t scaleBy: 5 ].
	^ aContainerElement
]

{ #category : #'rectangle and start' }
BlGeometryVisualAndLayoutBoundsExamples >> insideOutskirts [
	<gtExample>
	<label: 'Rectangle and star elements with inside stroke'>
	<return: #BlElement>
	| aContainer |
	aContainer := self container.
	aContainer addChild: self rectangleWithSmallerGeometryInside.
	aContainer addChild: self starWithSmallerGeometryInside.

	^ aContainer
]

{ #category : #'debugging triangle and text' }
BlGeometryVisualAndLayoutBoundsExamples >> misalignedIcon [
	<gtExample>
	<return: #BlElement>
	| anIconElement aLabelElement aContainerElement |
	anIconElement := self emptyIconElement geometry: self misalignedTrianglePolygon.
	aLabelElement := self textElementWithRunText.
	aContainerElement := self iconAndTextContainer.
	aContainerElement
		addChildren: {anIconElement.
				aLabelElement}.
	^ aContainerElement
]

{ #category : #'debugging triangle and text' }
BlGeometryVisualAndLayoutBoundsExamples >> misalignedTrianglePolygon [
	<gtExample>
	<label: 'Triangle polygon'>
	<return: #BlPolygonGeometry>
	^ BlPolygonGeometry
		vertices: {0 @ 3.
				8 @ 7.5.
				0 @ 12}
]

{ #category : #'rectangle and start' }
BlGeometryVisualAndLayoutBoundsExamples >> outsideOutskirts [
	<gtExample>
	<label: 'Rectangle and star elements with outside stroke'>
	<return: #BlElement>
	| aContainer |
	aContainer := self container.
	aContainer addChild: self rectangleWithSmallerGeometryOutside.
	aContainer addChild: self starWithSmallerGeometryOutside.

	^ aContainer
]

{ #category : #rectangle }
BlGeometryVisualAndLayoutBoundsExamples >> rectanglePolygon [
	<gtExample>
	<label: 'Rectangle polygon'>
	<return: #BlPolygonGeometry>
	^ BlPolygonGeometry
		vertices: {50 @ 50.
				150 @ 50.
				150 @ 100.
				50 @ 100}
]

{ #category : #rectangle }
BlGeometryVisualAndLayoutBoundsExamples >> rectangleWithSmallerGeometry [
	<gtExample>
	<label: 'Rectangle element in debug mode, displaying bounds'>
	<return: #BlDevElement>
	| aRectangleElement |
	aRectangleElement := BlDevElement new.
	aRectangleElement geometry: self rectanglePolygon.
	aRectangleElement size: 200 @ 150.
	aRectangleElement background: (Color gray alpha: 0.2).
	aRectangleElement border: (BlBorder paint: (Color gray alpha: 0.5) width: 10).

	^ aRectangleElement
]

{ #category : #rectangle }
BlGeometryVisualAndLayoutBoundsExamples >> rectangleWithSmallerGeometryCentered [
	<gtExample>
	<label: 'Rectangle element with centered stroke'>
	<return: #BlDevElement>
	| aRectangleElement |
	aRectangleElement := self rectangleWithSmallerGeometry.
	aRectangleElement outskirts: BlOutskirts centered.

	^ aRectangleElement
]

{ #category : #rectangle }
BlGeometryVisualAndLayoutBoundsExamples >> rectangleWithSmallerGeometryInside [
	<gtExample>
	<label: 'Rectangle element with inside stroke'>
	<return: #BlDevElement>
	| aRectangleElement |
	aRectangleElement := self rectangleWithSmallerGeometry.
	aRectangleElement outskirts: BlOutskirts inside.

	^ aRectangleElement
]

{ #category : #rectangle }
BlGeometryVisualAndLayoutBoundsExamples >> rectangleWithSmallerGeometryOutside [
	<gtExample>
	<label: 'Rectangle element with outside stroke'>
	<return: #BlDevElement>
	| aRectangleElement |
	aRectangleElement := self rectangleWithSmallerGeometry.
	aRectangleElement outskirts: BlOutskirts outside.

	^ aRectangleElement
]

{ #category : #star }
BlGeometryVisualAndLayoutBoundsExamples >> starPolygon [
	<gtExample>
	<label: 'Star polygon'>
	<return: #BlPolygonGeometry>
	^ BlPolygonGeometry
		vertices: {100 @ 50.
				115 @ 90.
				150 @ 90.
				125 @ 110.
				135 @ 150.
				100 @ 130.
				65 @ 150.
				75 @ 110.
				50 @ 90.
				85 @ 90}
]

{ #category : #star }
BlGeometryVisualAndLayoutBoundsExamples >> starWithSmallerGeometry [
	<gtExample>
	<label: 'Star element in debug mode, displaying bounds'>
	<return: #BlDevElement>
	| aStarElement |
	aStarElement := BlDevElement new.
	aStarElement geometry: self starPolygon.
	aStarElement size: 200 @ 200.
	aStarElement background: (Color gray alpha: 0.2).
	aStarElement border: (BlBorder paint: (Color gray alpha: 0.5) width: 10).
	^ aStarElement
]

{ #category : #star }
BlGeometryVisualAndLayoutBoundsExamples >> starWithSmallerGeometryCentered [
	<gtExample>
	<label: 'Star element with centered stroke'>
	<return: #BlDevElement>
	| aStarElement |
	aStarElement := self starWithSmallerGeometry.
	aStarElement outskirts: BlOutskirts centered.

	^ aStarElement
]

{ #category : #star }
BlGeometryVisualAndLayoutBoundsExamples >> starWithSmallerGeometryInside [
	<gtExample>
	<label: 'Star element with inside stroke'>
	<return: #BlDevElement>
	| aStarElement |
	aStarElement := self starWithSmallerGeometry.
	aStarElement outskirts: BlOutskirts inside.

	^ aStarElement
]

{ #category : #star }
BlGeometryVisualAndLayoutBoundsExamples >> starWithSmallerGeometryOutside [
	<gtExample>
	<label: 'Star element with outside stroke'>
	<return: #BlDevElement>
	| aStarElement |
	aStarElement := self starWithSmallerGeometry.
	aStarElement outskirts: BlOutskirts outside.

	^ aStarElement
]

{ #category : #'debugging triangle and text' }
BlGeometryVisualAndLayoutBoundsExamples >> textElementWithRunText [
	<gtExample>
	<return: #BlTextElement>
	^ BlTextElement new text: 'Run' asRopedText
]

{ #category : #'debugging triangle and text' }
BlGeometryVisualAndLayoutBoundsExamples >> trianglePolygon [
	<gtExample>
	<label: 'Triangle polygon'>
	<return: #BlPolygonGeometry>
	^ BlPolygonGeometry
		vertices: {0 @ 0.
				8 @ 6.
				0 @ 12}
]

{ #category : #bounds }
BlGeometryVisualAndLayoutBoundsExamples >> unclippedTriangle [
	<gtExample>
	<label: 'Clipped triangle polygon with layount bounds'>
	<return: #BlElement>
	| aContainer aPolygonElement |
	aContainer := BlElement new.
	aContainer size: 8 @ 11.
	aContainer relocate: 50 @ 50.
	aContainer clipChildren: false.
	aContainer
		transformDo: [ :t | 
			t origin: BlAffineTransformationTopLeftOrigin new.
			t scaleBy: 10 ].
	aContainer outskirts: BlOutskirts centered.
	aContainer border: (BlBorder paint: (Color green alpha: 0.4) width: 0.2).

	aPolygonElement := BlElement new.
	aPolygonElement size: 8 @ 11.
	aPolygonElement
		geometry: (BlPolygonGeometry
				vertices: {0 @ 0.
						8 @ 5.5.
						0 @ 11}).
	aPolygonElement border: (BlBorder paint: (Color gray alpha: 0.4) width: 2).
	aPolygonElement outskirts: BlOutskirts centered.

	aContainer addChild: aPolygonElement.

	^ aContainer
]
