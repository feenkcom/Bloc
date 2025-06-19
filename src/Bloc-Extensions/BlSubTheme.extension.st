Extension { #name : #BlSubTheme }

{ #category : #'*Bloc-Extensions' }
BlSubTheme >> gtThemeChildren [
	| someSlots |
	someSlots := self class allSlots select: [ :each | each isVirtual not ].
	someSlots sort: [ :a :b | a index < b index ].
	^ someSlots
		collect: [ :each | each name -> (each read: self) ]
		thenSelect: [ :each | each value isColor ]
]
