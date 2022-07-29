"
# Bloc

Bloc is a graphical framework that is drawing agnostic. The concrete drawing is achieved through the binding to the Sparta canvas. See {{gtClass:BaselineOfSparta}} for more details.

The central concept is {{gtClass:BlElement}}.

## Organization

The packages of Bloc are organized as follows. The visualization also shows the depended projects in gray: {{gtClass:BaselineOfBloc|show=#gtPackagesMapFor:|expanded=true}}

## Tutorial

You can learn Bloc following a memory game tutorial: [00-memory-game.pillar](fileLocator://gtResource/feenkcom/Bloc/doc/tutorial-memory-game/00-memory-game.pillar).


"
Class {
	#name : #BaselineOfBloc,
	#superclass : #BaselineOf,
	#classVars : [
		'PostLoaded'
	],
	#category : #BaselineOfBloc
}

{ #category : #baseline }
BaselineOfBloc >> baseline: spec [
	<baseline>
	spec for: #'common' do: [
		spec postLoadDoIt: #'postLoadBloc:'.
		spec
			baseline: 'Beacon' with: [
				spec repository: 'github://feenkcom/pharo-beacon:4022524a49bdebd091df79cec0230cc44c20d036/repository' ].
		spec
			baseline: 'Telemetry' with: [
				spec repository: 'github://feenkcom/pharo-telemetry:v0.6.9/src' ].
		spec
			baseline: 'Futures' with: [
				spec repository: 'github://feenkcom/pharo-futures:v0.6.48/src' ].
		spec
			baseline: 'Fenster' with: [
				spec repository: 'github://feenkcom/fenster:v0.8.22/src' ].
		spec
			baseline: 'Sparta' with: [
				spec repository: 'github://feenkcom/Sparta:v0.8.107/src' ].
		spec
			baseline: 'Glutin' with: [
				spec repository: 'github://feenkcom/gtoolkit-glutin:v0.8.89/src' ].

		spec package: 'Bloc' with: [
			spec requires: #('Beacon' 'Fenster' 'Telemetry' 'Futures') ].
		spec package: 'Bloc-Animation' with: [
			spec requires: #(#Bloc) ].
		spec package: 'Bloc-Layout' with: [
			spec requires: #(#Bloc #'Bloc-Animation') ].
		spec package: 'Bloc-Text' with: [
			spec requires: #(#Bloc) ].
		spec package: 'Bloc-Text-Rope' with: [
			spec requires: #(#Bloc #'Bloc-Text') ].
		spec package: 'Bloc-Text-Elements' with: [
			spec requires: #(#Bloc #'Bloc-Text' #'Bloc-Text-Rope') ].
		spec package: 'BlocHost-Mock' with: [
			spec requires: #(#Bloc #Bloc) ].
		spec package: 'BlocHost-Morphic' with: [
			spec requires: #(#Bloc) ].
		spec package: 'Bloc-Tests' with: [
			spec requires: #(#Bloc #'BlocHost-Mock') ].
		spec package: 'BlocHost-Glutin' with: [
			spec requires: #(#Bloc 'Fenster' 'Glutin') ].
		spec package: 'Bloc-Compositor' with: [
			spec requires: #(#Bloc 'Sparta') ].
		spec package: 'Bloc-Sparta' with: [
			spec requires: #('Sparta' #Bloc #'Bloc-Text' #'Bloc-Text-Elements' #'Bloc-Compositor') ].
		spec package: 'Bloc-Exporter' with: [
			spec requires: #(#Bloc #'Bloc-Sparta') ].
		spec package: 'Bloc-DevTool' with: [
			spec requires: #(#Bloc #'Bloc-Layout' #'Bloc-Text-Elements' #'Bloc-Text-Rope') ].
		spec package: 'Bloc-Scripter' with: [
			spec requires: #(#Bloc #'Bloc-Layout' #'Bloc-Exporter' #'BlocHost-Mock') ].
	]
]

{ #category : #'post load' }
BaselineOfBloc >> postLoadBloc: spec [
	(PostLoaded isNotNil and: [ PostLoaded ])
		ifTrue: [ ^ self ].
		
	PostLoaded := true.
	self postLoadMorphicHost: spec
]

{ #category : #'post load' }
BaselineOfBloc >> postLoadMorphicHost: spec [

	"This will select an appropriate UI manager"
	SystemVersion current major < 8
		ifTrue: [ UIManager default: UIManager forCurrentSystemConfiguration ]
]
