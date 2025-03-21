Class {
	#name : #BlElementDisjunctionState,
	#superclass : #BlElementCompositeState,
	#category : #'Bloc-Core-State'
}

{ #category : #testing }
BlElementDisjunctionState >> matches: aSetOfStates [
	^ (self left matches: aSetOfStates) or: [ self right matches: aSetOfStates ]
]

{ #category : #printing }
BlElementDisjunctionState >> printOn: aStream [
	aStream
		nextPut: $(;
		print: self left;
		nextPutAll: ' | ';
		print: self right;
		nextPut: $)
]
