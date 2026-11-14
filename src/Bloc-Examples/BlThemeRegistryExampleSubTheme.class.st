"
An example subtheme that verifies it is registered before themeable colors are initialized.
"
Class {
	#name : #BlThemeRegistryExampleSubTheme,
	#superclass : #BlSubTheme,
	#instVars : [
		'registryKey'
	],
	#category : #'Bloc-Examples-Core-Theme'
}

{ #category : #initialization }
BlThemeRegistryExampleSubTheme >> initializeThemeable [
	super initializeThemeable.
	self
		assert: (self theme
				subThemeAt: registryKey
				ifAbsentPut: [ self error: 'Register the subtheme before initializing it' ])
				== self
]

{ #category : #accessing }
BlThemeRegistryExampleSubTheme >> registryKey: aKey [
	registryKey := aKey
]
