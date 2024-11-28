Extension { #name : #String }

{ #category : #'*Bloc' }
String >> asBlocElementId [
	<return: #BlElementId>

	^ BlElementId named: self asSymbol
]

{ #category : #'*Bloc' }
String >> gtCharIndexAtByteOffset: anOffset [
	^ self subclassResponsibility
]
