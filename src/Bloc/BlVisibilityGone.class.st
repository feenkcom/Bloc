"
I am a concrete visibility type - ""gone"".
Once set, element should not be rendered and should not participate in layout (should not take space)

"
Class {
	#name : #BlVisibilityGone,
	#superclass : #BlVisibility,
	#category : #'Bloc-Core-Properties'
}

{ #category : #testing }
BlVisibilityGone >> isGone [
	^ true
]

{ #category : #testing }
BlVisibilityGone >> isHidden [
	^ true
]
