Class {
	#name : #BlHorizontalTreeFlowLayoutConstraints,
	#superclass : #BlLayoutConstraints,
	#instVars : [
		'row',
		'depth'
	],
	#category : #'Bloc-Layout-Tree-Flow'
}

{ #category : #accessing }
BlHorizontalTreeFlowLayoutConstraints >> depth [
	^ depth
]

{ #category : #accessing }
BlHorizontalTreeFlowLayoutConstraints >> depth: aNumber [
	aNumber < 1 ifTrue: [
		SubscriptOutOfBounds signalFor: aNumber
			lowerBound: 1
			upperBound: nil ].

	depth := aNumber
]

{ #category : #'as yet unclassified' }
BlHorizontalTreeFlowLayoutConstraints >> initialize [
	super initialize.
	
	row := 1.
	depth := 1.
]

{ #category : #accessing }
BlHorizontalTreeFlowLayoutConstraints >> row [
	^ row
]

{ #category : #accessing }
BlHorizontalTreeFlowLayoutConstraints >> row: aNumber [
	aNumber < 1 ifTrue: [
		SubscriptOutOfBounds signalFor: aNumber
			lowerBound: 1
			upperBound: nil ].
			
	row := aNumber
]
