Extension { #name : #BlockClosure }

{ #category : #'*Bloc' }
BlockClosure >> asBlTask [
	^ BlTaskAction new action: self
]

{ #category : #'*Bloc' }
BlockClosure >> asBlocResolvedElementsFrom: anElement [
	self argumentCount isZero
		ifTrue: [ ^ self value ].
		
	^ Array streamContents: [ :aStream |
		self value: [ :eachElement |
			aStream nextPut: eachElement ] ]
]

{ #category : #'*Bloc' }
BlockClosure >> blocDefiningMethod [
	^ self method ifNotNil: #blocDefiningMethod
]
