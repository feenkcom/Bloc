Class {
	#name : #BlGlutinWindowEventsSensor,
	#superclass : #GlutinWindowEventsSensor,
	#instVars : [
		'hostClass'
	],
	#category : #'BlocHost-Glutin-Host'
}

{ #category : #'instance creation' }
BlGlutinWindowEventsSensor class >> forHost: aBlRustWindowingHost [
	^ self new hostClass: aBlRustWindowingHost
]

{ #category : #accessing }
BlGlutinWindowEventsSensor >> hostClass [

	^ hostClass
]

{ #category : #accessing }
BlGlutinWindowEventsSensor >> hostClass: anObject [

	hostClass := anObject
]

{ #category : #'event - handling' }
BlGlutinWindowEventsSensor >> processCommonEvent: aGlutinCommonEvent forWindow: aGlutinWindow [

	self
		assert: [ aGlutinWindow isValid ]
		description: [ 'Window must be valid' ].

	hostClass
		hostForWindow: aGlutinWindow
		do: [ :aHostSpace | aGlutinCommonEvent accept: aHostSpace ]
]

{ #category : #'event - handling' }
BlGlutinWindowEventsSensor >> processDeviceEvent: aGlutinDeviceEvent forWindow: aGlutinWindow [

	self
		assert: [ aGlutinWindow isValid ]
		description: [ 'Window must be valid' ].

	hostClass
		hostForWindow: aGlutinWindow
		do: [ :aHostSpace | aGlutinDeviceEvent accept: aHostSpace ]
]

{ #category : #'event - handling' }
BlGlutinWindowEventsSensor >> processWindowEvent: aGlutinWindowEvent forWindow: aWindow [

	self
		assert: [ aWindow isValid ]
		description: [ 'Window must be valid' ].

	hostClass
		hostForWindow: aWindow
		do: [ :aHostSpace | aGlutinWindowEvent accept: aHostSpace ]
]
