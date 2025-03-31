"
I define common step target definitions.
"
Trait {
	#name : #TBlDevScripterTarget,
	#category : #'Bloc-Scripter-Scripter'
}

{ #category : #'targets - other' }
TBlDevScripterTarget >> event: anEventClass [
	"Find the latest event of the given kind"
	<scripterStepTarget>

	self updateTarget: (BlScripterEventTarget new eventClass: anEventClass)
]

{ #category : #'targets - other' }
TBlDevScripterTarget >> event: anEventClass index: anEventIndex [
	"Find the Nth event of the given kind (latest first)"
	<scripterStepTarget>

	self updateTarget: (BlScripterEventTarget new eventClass: anEventClass; eventIndex: anEventIndex)
]

{ #category : #'targets - children' }
TBlDevScripterTarget >> id: aBlElementId [
	"Find an element with a given index (depth first)"
	<scripterStepTarget>

	self updateTarget: (BlDevScripterElementIdEventTarget new elementId: aBlElementId)
]

{ #category : #'targets - children' }
TBlDevScripterTarget >> id: aBlElementId index: anIndex [
	"Find the Nth element with a given index (depth first)"
	<scripterStepTarget>

	self updateTarget: (BlDevScripterElementIdEventTarget new elementId: aBlElementId; index: anIndex)
]

{ #category : #'targets - children' }
TBlDevScripterTarget >> onBreadthFirstChildOfClass: aClass [
	self updateTarget: (BlDevScripterDeepChildOfClassEventTarget new elementClass: aClass)
]

{ #category : #'targets - children' }
TBlDevScripterTarget >> onChildAt: aNumber [
	"Select the Nth direct child of the current target"
	<scripterStepTarget>

	self updateTarget: (BlDevScripterIndexedChildEventTarget new index: aNumber)
]

{ #category : #'targets - children' }
TBlDevScripterTarget >> onChildFromBlock: anOneArgBlock [
	self updateTarget: (BlDevScripterBlockSelectorEventTarget new block: anOneArgBlock)
]

{ #category : #'targets - children' }
TBlDevScripterTarget >> onChildFromMessage: aSymbol [
	self updateTarget: (BlDevScripterSelectorChildEventTarget new selector: aSymbol)
]

{ #category : #'targets - children' }
TBlDevScripterTarget >> onChildNamed: aSymbol [
	self
		deprecated: 'Use #id: instead'
		transformWith: '`@receiver onChildNamed: `@arg'' -> ''`@receiver id: `@arg'.
	
	self id: aSymbol
]

{ #category : #'targets - children' }
TBlDevScripterTarget >> onChildOfClass: aClass [
	"Select a direct child of a given class"
	<scripterStepTarget>

	self updateTarget: (BlDevScripterElementClassEventTarget new elementClass: aClass)
]

{ #category : #'targets - other' }
TBlDevScripterTarget >> onElement: anElement [
	self target: (BlDevScripterElementTarget new element: anElement)
]

{ #category : #'targets - other' }
TBlDevScripterTarget >> onFocusProcessor [
	self updateTarget: (BlDevScripterFocusProcessorTarget new)
]

{ #category : #'targets - other' }
TBlDevScripterTarget >> onModel [
	self target: (BlDevScripterModelTarget new)
]

{ #category : #'targets - other' }
TBlDevScripterTarget >> onMouseProcessor [
	self target: (BlDevScripterMouseProcessorTarget new)
]

{ #category : #'targets - other' }
TBlDevScripterTarget >> onParentStepTarget: aParentStep [
	self updateTarget: (BlDevScripterParentStepTarget new parentStep: aParentStep)
]

{ #category : #'targets - other' }
TBlDevScripterTarget >> onScripter [
	self target: (BlDevScripterAsTarget new)
]

{ #category : #'targets - children' }
TBlDevScripterTarget >> onSelected: aBlock [
	self updateTarget: (BlDevScripterSelectFilterEventTarget new block: aBlock)
]

{ #category : #'targets - children' }
TBlDevScripterTarget >> onSelf [
	self target: BlDevScripterSelfEventTarget new
]

{ #category : #'targets - other' }
TBlDevScripterTarget >> onSpace [
	self target: (BlDevScripterSpaceTarget new)
]

{ #category : #'targets - other' }
TBlDevScripterTarget >> onSpaceRoot [
	self target: BlDevScripterSpaceRootTarget new
]

{ #category : #'targets - children' }
TBlDevScripterTarget >> onTarget: oneArgBlock [
	oneArgBlock value: self
]

{ #category : #'targets - text' }
TBlDevScripterTarget >> onTextAttributesAt: anIndex [
	self updateTarget: (BlDevScripterTextAttributesAtTarget new index: anIndex)
]

{ #category : #'targets - children' }
TBlDevScripterTarget >> onThisOrBreadthFirstChildOfClass: aClass [
	self updateTarget: (BlDevScripterThisOrDeepChildOfClassEventTarget new elementClass: aClass)
]

{ #category : #'targets - children' }
TBlDevScripterTarget >> onThisOrBreadthFirstChildOfKind: aClass [
	self updateTarget: (BlDevScripterThisOrDeepChildOfKindEventTarget new elementClass: aClass)
]

{ #category : #'targets - children' }
TBlDevScripterTarget >> onThisOrDeepChildElementId: aBlElementId [
	"Find an element with a given index (depth first)"
	<scripterStepTarget>

	self updateTarget: (BlDevScripterThisOrDeepChildElementIdEventTarget new elementId: aBlElementId)
]

{ #category : #'targets - children' }
TBlDevScripterTarget >> onThisOrDeepChildElementId: aBlElementId index: anIndex [
	"Find an element with a given index (depth first)"
	<scripterStepTarget>

	self updateTarget: (BlDevScripterThisOrDeepChildElementIdEventTarget new elementId: aBlElementId; index: anIndex)
]

{ #category : #'targets - other' }
TBlDevScripterTarget >> onTopMost [
	self updateTarget: BlDevScripterTopMostTarget new
]

{ #category : #'targets - children' }
TBlDevScripterTarget >> onWithAllChildrenBreadthFirst [
	self updateTarget: (BlDevScripterWithAllChildrenBreadthFirstEventTarget new)
]

{ #category : #'targets - accessing and updating' }
TBlDevScripterTarget >> target [
	<return: #BlScripterElementTarget>
	self explicitRequirement
]

{ #category : #'targets - accessing and updating' }
TBlDevScripterTarget >> target: aScripterEventTarget [
	self explicitRequirement
]

{ #category : #'targets - accessing and updating' }
TBlDevScripterTarget >> updateTarget: aScripterEventTarget [
	self target 
		ifNil: [ self target: aScripterEventTarget ]
		ifNotNil: [ :aTarget | aTarget updateUsing: aScripterEventTarget on: self ]
]
