"
Fitting for ordered contiguous disjoint spans covering an axis. Explains requirements as an additive capacity comparison and draws children end-to-end. Uses the shared constraint-backed search.
"
Class {
	#name : #BlGridSequentialSizeFitting,
	#superclass : #BlGridSizeFitting,
	#category : #'Bloc-Layout-Grid-Utilities'
}

{ #category : #presentation }
BlGridSequentialSizeFitting >> childOffsetAt: index in: aStep [
	| offset |
	offset := 0.
	1
		to: index - 1
		do: [ :i | offset := offset + (aStep sizes at: i) + (self childMargins at: i) ].
	^ offset
]

{ #category : #presentation }
BlGridSequentialSizeFitting >> childYAt: index [
	^ 28
]

{ #category : #presentation }
BlGridSequentialSizeFitting >> diagramHeightFor: aStep [
	^ 40
]

{ #category : #presentation }
BlGridSequentialSizeFitting >> explanation [
	^ 'Sequential disjoint spans: requirements add together. Children are drawn end-to-end; gaps represent margins and spacing.'
]

{ #category : #accessing }
BlGridSequentialSizeFitting >> isSequential [
	^ true
]

{ #category : #presentation }
BlGridSequentialSizeFitting >> requirementsTitle [
	^ 'Sizes'
]

{ #category : #presentation }
BlGridSequentialSizeFitting >> sizesExpressionFor: aStep [
	^ String
		streamContents: [ :stream | 
			aStep sizes
				withIndexDo: [ :size :index | 
					index > 1 ifTrue: [ stream nextPutAll: ' + ' ].
					stream print: size ].
			self childMargins sum isZero
				ifFalse: [ stream
						nextPutAll: ' + ';
						print: self childMargins sum;
						nextPutAll: ' (margins)' ].
			availableSpace
				ifNotNil: [ stream
						nextPutAll: (aStep attemptedSpace < availableSpace
								ifTrue: [ ' < ' ]
								ifFalse: [ aStep attemptedSpace > availableSpace ifTrue: [ ' > ' ] ifFalse: [ ' = ' ] ]);
						print: availableSpace ] ]
]
