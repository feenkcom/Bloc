Extension { #name : #BlCompositeSelection }

{ #category : #'*Bloc-Extensions' }
BlCompositeSelection >> gtTreeFor: aView [
	<gtView>		
	^ selections gtTreeFor: aView
]
