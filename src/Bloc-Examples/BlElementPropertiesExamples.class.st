Class {
	#name : #BlElementPropertiesExamples,
	#superclass : #Object,
	#category : #'Bloc-Examples-Basic'
}

{ #category : #examples }
BlElementPropertiesExamples >> addChildAndGrandChildToSceneWithPropagatableProperties [
	<gtExample>
	| space container child grandChild |
	
	grandChild := BlElement new.
	child := BlElement new.
	child addChild: grandChild.
	
	self assert: child needsPropertiesComputation not.
	self assert: child needsPropertiesComputationAfterAttachingSpace not.
	self assert: grandChild needsPropertiesComputation not.
	self assert: grandChild needsPropertiesComputationAfterAttachingSpace not.
	
	space := self sceneWithPropagatableProperties.
	container := space root childWithId: #container.
	container addChild: child.
	
	self assert: child needsPropertiesComputation.
	self assert: child needsPropertiesComputationAfterAttachingSpace.
	self assert: grandChild needsPropertiesComputation not.
	self assert: grandChild needsPropertiesComputationAfterAttachingSpace not.
	
	self assert: (container userData at: #exampleProperty).
	self assert: (child userData includesKey: #exampleProperty) not.
	self assert: (grandChild userData includesKey: #exampleProperty) not.
	
	space pulse.
	
	self assert: (container userData at: #exampleProperty).
	self assert: (child userData at: #exampleProperty).
	self assert: (grandChild userData at: #exampleProperty).
	
	^ space
]

{ #category : #examples }
BlElementPropertiesExamples >> addChildThenGrandChildToSceneWithPropagatableProperties [
	<gtExample>
	| space container child grandChild |
	
	grandChild := BlElement new.
	child := BlElement new.
	
	self assert: child needsPropertiesComputation not.
	self assert: child needsPropertiesComputationAfterAttachingSpace not.
	self assert: grandChild needsPropertiesComputation not.
	self assert: grandChild needsPropertiesComputationAfterAttachingSpace not.
	
	space := self sceneWithPropagatableProperties.
	container := space root childWithId: #container.
	container addChild: child.
	
	self assert: child needsPropertiesComputation.
	self assert: child needsPropertiesComputationAfterAttachingSpace.
	self assert: grandChild needsPropertiesComputation not.
	self assert: grandChild needsPropertiesComputationAfterAttachingSpace not.
	
	self assert: (container userData at: #exampleProperty).
	self assert: (child userData includesKey: #exampleProperty) not.
	self assert: (grandChild userData includesKey: #exampleProperty) not.
	
	child addChild: grandChild.
	
	self assert: child needsPropertiesComputation.
	self assert: child needsPropertiesComputationAfterAttachingSpace.
	self assert: grandChild needsPropertiesComputation not.
	self assert: grandChild needsPropertiesComputationAfterAttachingSpace not.
	
	self assert: (container userData at: #exampleProperty).
	self assert: (child userData includesKey: #exampleProperty) not.
	self assert: (grandChild userData includesKey: #exampleProperty) not.
	
	space pulse.
	
	self assert: (container userData at: #exampleProperty).
	self assert: (child userData at: #exampleProperty).
	self assert: (grandChild userData at: #exampleProperty).
	
	^ space
]

{ #category : #examples }
BlElementPropertiesExamples >> sceneWithPropagatableProperties [
	<gtExample>
	| space container |
	
	container := BlElement new.
	container properties addProperty: (BlExamplePropagatableProperty new).
	container id: #container.

	self assert: container needsPropertiesComputation.
	self assert: container needsPropertiesComputationAfterAttachingSpace.
	
	space := BlSpace new.
	space addChild: container.
	space pulse.
	
	self assert: (container userData at: #exampleProperty).
	
	^ space
]
