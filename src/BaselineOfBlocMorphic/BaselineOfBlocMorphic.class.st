Class {
	#name : #BaselineOfBlocMorphic,
	#superclass : #BaselineOf,
	#classVars : [
		'PostLoaded'
	],
	#category : #BaselineOfBlocMorphic
}

{ #category : #baseline }
BaselineOfBlocMorphic >> baseline: spec [
	<baseline>
	spec for: #'common' do: [
		spec 
			baseline: 'BlocCore' with: [
				spec repository: 'github://feenkcom/Bloc:v0.8.121/src' ];
			baseline: 'GToolkitFenster' with: [
				spec repository: 'github://feenkcom/gtoolkit-fenster:v0.8.16/src' ].
		spec package: #'BlocHost-Morphic' with: [
				spec requires: #('BlocCore' 'GToolkitFenster' ). ]. ].

]

{ #category : #'post load' }
BaselineOfBlocMorphic >> postLoadBloc: spec [
	(PostLoaded isNotNil and: [ PostLoaded ])
		ifTrue: [ ^ self ].
		
	PostLoaded := true.
	self postLoadMorphicHost: spec
]

{ #category : #'post load' }
BaselineOfBlocMorphic >> postLoadMorphicHost: spec [

	"This will select an appropriate UI manager"
	SystemVersion current major < 8
		ifTrue: [ UIManager default: UIManager forCurrentSystemConfiguration ]
]
