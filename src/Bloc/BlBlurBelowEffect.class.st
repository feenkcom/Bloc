Class {
	#name : #BlBlurBelowEffect,
	#superclass : #BlBlurEffect,
	#category : #'Bloc-Effect'
}

{ #category : #testing }
BlBlurBelowEffect >> wantsCompositionLayer [
	"Blur below must be composed in the parent surface so that it can sample
	the content behind the element."
	^ false
]

{ #category : #testing }
BlBlurBelowEffect >> wantsCompositionLayerForOpacity [
	^ true
]
