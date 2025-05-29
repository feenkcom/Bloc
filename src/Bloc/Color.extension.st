Extension { #name : #Color }

{ #category : #'*Bloc' }
Color >> asBlBackground [
	^ BlBackground paint: self
]

{ #category : #'*Bloc' }
Color >> asBlBorder [
	^ BlBorder paint: self
]

{ #category : #'*Bloc' }
Color >> asBlPaint [
	^ BlColorPaint color: self
]

{ #category : #'*Bloc' }
Color >> blocResolveColorForTheme: aBlTheme [
	^ self
]
