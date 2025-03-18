Extension { #name : #BlElement }

{ #category : #'*Bloc-Extensions' }
BlElement >> gtDropdownActionFor: aView [
	<gtView>
	| aDropdownAptitude |
	aDropdownAptitude := nil.
	self
		aptitudeDo: [ :anAptitude | 
			anAptitude
				withAllActorsBreadthFirstDo: [ :eachActor | 
					(aDropdownAptitude isNil
						and: [ eachActor isKindOf: BrWithExplicitDropdownAptitude ])
						ifTrue: [ aDropdownAptitude := eachActor ] ] ].

	aDropdownAptitude ifNil: [ ^ aView empty ].
	(aDropdownAptitude respondsTo: #gtSourceCodeFor:) ifFalse: [ ^ aView empty ].

	^ (aDropdownAptitude gtSourceCodeFor: aView)
		title: 'Action';
		priority: 20
]
