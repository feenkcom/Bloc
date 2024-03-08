Class {
	#name : #BlDevScripterTopMostTarget,
	#superclass : #BlScripterElementTarget,
	#category : #'Bloc-Scripter-Scripter-Targets'
}

{ #category : #searching }
BlDevScripterTopMostTarget >> findTargetIn: anElementOrCollection [
	<return: #BlElement or: #Collection>
	| aMinDepth aSelection |
	anElementOrCollection isCollection ifFalse: [ ^ anElementOrCollection ].

	aMinDepth := (anElementOrCollection
			detectMin: [ :each | each withAllParents size ]) withAllParents size.

	aSelection := anElementOrCollection
			select: [ :each | each withAllParents size = aMinDepth ].
	^ aSelection size = 1 ifTrue: [ aSelection anyOne ] ifFalse: [ aSelection ]
]

{ #category : #accessing }
BlDevScripterTopMostTarget >> identifier [
	^ 'top-most'
]

{ #category : #printing }
BlDevScripterTopMostTarget >> printOn: aStream [
	aStream nextPutAll: 'top-most'
]
