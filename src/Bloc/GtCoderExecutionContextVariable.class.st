"
I am a {{gtClass:DynamicVariable}}.
I hold a {{gtMethod:BlSpace>>id}} as a {{gtClass:Process}} specific value.
I am used to pass an execution context information that can be requested, for example to display a user information.
1. # Usage
## Initializing Execution Context

To initialize execution context value using a {{gtClass:BlElement}}, use {{gtMethod:GtCoderExecutionContextVariable class>>#element:do:|label=#selector|expanded=true}} class-side method:
1. ## Obtaining Execution Context

To obtain the execution context, use {{gtMethod:GtCoderExecutionContextVariable class>>#spaceDo:ifClosed:|label=#selector|expanded=true}} class-side method:


"
Class {
	#name : #GtCoderExecutionContextVariable,
	#superclass : #DynamicVariable,
	#category : #'Bloc-Basic'
}

{ #category : #'api - execution' }
GtCoderExecutionContextVariable class >> element: anElement do: aBlock [
	"Initialize a Space ID using the element and evaluate the block"
	| aSpaceId |
	aSpaceId := self newSpaceIdFromElement: anElement.
	^ self
		value: aSpaceId
		during: aBlock
]

{ #category : #testing }
GtCoderExecutionContextVariable class >> isInheritable [
	^true
]

{ #category : #'private - instance creation' }
GtCoderExecutionContextVariable class >> newSpaceIdFromElement: anElement [
	anElement spaceDo: [ :aSpace | 
		^ aSpace id ].
	^ nil
]

{ #category : #'api - execution' }
GtCoderExecutionContextVariable class >> spaceDo: aSpaceBlock ifClosed: aClosedBlock [
	self value ifNotNil: [ :aSpaceId |
		BlSpace
			spaceWithId: aSpaceId
			do: [ :aSpace | ^ aSpaceBlock cull: aSpace ] ].
	^ aClosedBlock value
]
