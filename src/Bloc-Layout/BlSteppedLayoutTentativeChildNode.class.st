"
I am a {{gtClass:BlLayoutNode}}. 
I can be measured several times.
I am used by {{gtClass:BlSteppedLayoutState}} to shrink children (if necessary) using the following steps:
- Instance creation: {{gtMethod:BlSteppedLayoutState>>#measureAndPlaceChild:}}, 
- Shrink computation: {{gtMethod:BlSteppedLayoutState>>#placeMeasuredChild:}}, 
- Result consolidation: {{gtMethod:BlSteppedLayoutState>>#measureAndPlaceChild:}}.
#Example
In the following example, the child is heigher than its parent. In this case, the child is shrinked to fit to its parent: {{gtExample:BlSteppedLayoutExamples >> #atMostNodeWithFirstHigherChild_moreRight_layoutState_measureFirstChild | codeExpanded=false | previewExpanded=true | previewHeight=700}}
"
Class {
	#name : #BlSteppedLayoutTentativeChildNode,
	#superclass : #BlLayoutNode,
	#traits : 'TBlLayoutNode + TBlLayoutChildNode',
	#classTraits : 'TBlLayoutNode classTrait + TBlLayoutChildNode classTrait',
	#instVars : [
		'childNode',
		'tentativeMeasurement'
	],
	#category : #'Bloc-Layout-Stepped'
}

{ #category : #accessing }
BlSteppedLayoutTentativeChildNode >> childNode: aLayoutNode [
	childNode := aLayoutNode.
]

{ #category : #'api - measure' }
BlSteppedLayoutTentativeChildNode >> consolidateMeasurement [
	"Consolidate measurement into the child node".
	childNode measurement: tentativeMeasurement
]

{ #category : #accessing }
BlSteppedLayoutTentativeChildNode >> constraints [
	^ childNode constraints
]

{ #category : #accessing }
BlSteppedLayoutTentativeChildNode >> constraints: aBlLayoutConstraints [
	childNode constraints: aBlLayoutConstraints
]

{ #category : #'api - geometry' }
BlSteppedLayoutTentativeChildNode >> extent [
	"Return the size of the node in the parent coordinate system"
	<return: #Point>

	^ tentativeMeasurement extent
]

{ #category : #initialization }
BlSteppedLayoutTentativeChildNode >> initialize [
	super initialize.
	
	tentativeMeasurement := BlLayoutNodeNullMeasurement new.
]

{ #category : #'api - geometry' }
BlSteppedLayoutTentativeChildNode >> layoutBounds [
	<return: #BlBounds>

	^ BlBounds
		origin: self position
		extent: self extent
]

{ #category : #'api - measure' }
BlSteppedLayoutTentativeChildNode >> measure: anExtentSpecOrBlock [
	tentativeMeasurement := childNode privateMeasurement measure: self with: anExtentSpecOrBlock
]

{ #category : #accessing }
BlSteppedLayoutTentativeChildNode >> measurement: aBlLayoutNodeMeasurement [
	tentativeMeasurement := aBlLayoutNodeMeasurement
]

{ #category : #accessing }
BlSteppedLayoutTentativeChildNode >> parent [
	<return: #BlLayoutParentNode>

	^ childNode parent
]

{ #category : #accessing }
BlSteppedLayoutTentativeChildNode >> parent: aBlLayoutParentNode [
	childNode parent: aBlLayoutParentNode
]

{ #category : #'api - actions' }
BlSteppedLayoutTentativeChildNode >> popAction [
	<return: #BlLayoutNodeElementAction or: #nil>

	^ childNode popAction
]

{ #category : #'api - geometry' }
BlSteppedLayoutTentativeChildNode >> position [
	"Return a position of the top left corner in the parent coordinate system"
	<return: #Point>
	
	^ tentativeMeasurement position
]

{ #category : #'api - geometry' }
BlSteppedLayoutTentativeChildNode >> position: aPoint [
	"Set position of the top left corner in the parent coordinate system"
	<return: #Point>
	
	tentativeMeasurement position: aPoint
]

{ #category : #printing }
BlSteppedLayoutTentativeChildNode >> printOn: aStream [
	aStream
		nextPutAll: 'Node position: ';
		print: self position;
		nextPutAll: ' extent: ';
		print: self extent
]

{ #category : #accessing }
BlSteppedLayoutTentativeChildNode >> privateMeasurement [
	<return: #BlLayoutNodeMeasurement>
	
	^ tentativeMeasurement
]

{ #category : #'api - actions' }
BlSteppedLayoutTentativeChildNode >> pushAction: aBlLayoutNodeElementAction [
	childNode pushAction: aBlLayoutNodeElementAction
]

{ #category : #accessing }
BlSteppedLayoutTentativeChildNode >> userData [
	<return: #Dictionary>
	
	^ childNode userData
]
