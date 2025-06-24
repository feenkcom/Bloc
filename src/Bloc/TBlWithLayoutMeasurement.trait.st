Trait {
	#name : #TBlWithLayoutMeasurement,
	#category : #'Bloc-Layouts-Basic'
}

{ #category : #protected }
TBlWithLayoutMeasurement >> extentMeasurentSpecForChild: anElement parentSpec: parentSpec widthUsed: widthUsed heightUsed: heightUsed [
	^ BlExtentMeasurementSpec new
		widthSpec: (self
				measurementSpecFor: parentSpec widthSpec
				usedSize: widthUsed
				resizer: anElement constraints horizontal resizer);
		heightSpec: (self
				measurementSpecFor: parentSpec heightSpec
				usedSize: heightUsed
				resizer: anElement constraints vertical resizer)
]

{ #category : #'private - measurement' }
TBlWithLayoutMeasurement >> measureChild: aChildElement parentSpec: anExtentSpec [
	"Measure a given child element allowing it to take as much space within parent
	as it want *does not* taking child's margin and parent's padding into account.
	Note: You are only allowed to use me in a context of BlLayout and not from outside"

	self
		measureChild: aChildElement
		parentSpec: anExtentSpec
		widthUsed: 0.0
		heightUsed: 0.0
]

{ #category : #protected }
TBlWithLayoutMeasurement >> measureChild: anElement parentSpec: parentSpec widthUsed: widthUsed heightUsed: heightUsed [
	"Measure anElement based on provided parent's extent measurement specification and used width and height.
	used width and height can contain margin and/or padding.
	@see BlElement>>#measurementSpecFor:usedSize:resizing: for more info"

	anElement
		measure: (self
				extentMeasurentSpecForChild: anElement
				parentSpec: parentSpec
				widthUsed: widthUsed
				heightUsed: heightUsed)
]

{ #category : #protected }
TBlWithLayoutMeasurement >> measureChildWithMargins: anElement parentSpec: parentSpec [
	"Measure anElement based on provided parent's extent measurement specification
	taking element's margin and parent's padding into account"
	
	self
		measureChildWithMargins: anElement
		parentSpec: parentSpec
		widthUsed: 0
		heightUsed: 0
]

{ #category : #protected }
TBlWithLayoutMeasurement >> measureChildWithMargins: anElement parentSpec: parentSpec widthUsed: widthUsed heightUsed: heightUsed [
	"Measure anElement based on provided parent's extent measurement specification and used width and height
	taking element's margin and parent's padding into account"
	
	self
		measureChild: anElement
		parentSpec: parentSpec
		widthUsed: anElement parent insets width + anElement outsets width + widthUsed
		heightUsed: anElement parent insets height + anElement outsets height + heightUsed
]

{ #category : #protected }
TBlWithLayoutMeasurement >> measurementSpecFor: parentSpec usedSize: usedSize resizer: childResizer [
	"I determinate what measurement specification my child should have
	based on parent's measurement spec and child's resizer property.
	
	parentSpec may have the following modes:
	 - At Most: parent's size can be at most as provided value 
	 - Exactly: parent's size equals provided value
	 - Unspecified: parent still has no idea how big it should be
	
	usedSize is a number describing how much child's size differs from parent one
		defined in parentSpec. usedSize can consist out of child's margin and/or
		parent's padding. Custom layouts may introduce more parameters that influence
		on final size of child.
	
	childResizer may be:
	 - Parent Match: meaning that child wants to be as big as parent is. It may also proportionally
	   depend on parent
	 - Wrap Content: child tries to be big enough to fit contained subnodes
	 - Exactly: child knows exactly how big it wants to be
	"
	<argument: #usedSize satisfies: #isBlocFiniteFloat>
	<return: #BlMeasurementSpec>
	| size |

   size := 0.0 max: (parentSpec size - usedSize).

	^ parentSpec mode measurement: childResizer with: size
]
