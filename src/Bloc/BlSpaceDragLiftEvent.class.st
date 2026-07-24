Class {
	#name : #BlSpaceDragLiftEvent,
	#superclass : #BlSpaceEvent,
	#instVars : [
		'dragDelegate',
		'position'
	],
	#category : #'Bloc-Events-Type-Space'
}

{ #category : #accessing }
BlSpaceDragLiftEvent >> delegate [
	self
		deprecated: 'Please use #dragDelegate instead.'
		transformWith: '`@receiver delegate' -> '`@receiver dragDelegate'.

	^ self dragDelegate
]

{ #category : #accessing }
BlSpaceDragLiftEvent >> delegate: aDragDelegate [
	self
		deprecated: 'Please use dragDelegate: instead.'
		transformWith:
			'`@receiver delegate: `@statements1'
				-> '`@receiver dragDelegate: `@statements1'.

	self dragDelegate: aDragDelegate
]

{ #category : #'as yet unclassified' }
BlSpaceDragLiftEvent >> dragDelegate [
	<return: #BlDragDelegate>
	
	^ dragDelegate
]

{ #category : #accessing }
BlSpaceDragLiftEvent >> dragDelegate: aDragDelegate [
	dragDelegate := aDragDelegate
]

{ #category : #accessing }
BlSpaceDragLiftEvent >> position [
	^ position
]

{ #category : #accessing }
BlSpaceDragLiftEvent >> position: anObject [
	position := anObject
]

{ #category : #sending }
BlSpaceDragLiftEvent >> sendTo: anObject [
	anObject spaceDragLiftEvent: self
]
