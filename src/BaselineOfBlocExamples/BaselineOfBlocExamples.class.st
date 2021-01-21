Class {
	#name : #BaselineOfBlocExamples,
	#superclass : #BaselineOf,
	#category : #BaselineOfBlocExamples
}

{ #category : #baseline }
BaselineOfBlocExamples >> baseline: spec [
	<baseline>
	spec for: #'common' do: [
		spec 
			baseline: 'Bloc' with: [
				spec repository: 'github://feenkcom/Bloc:v0.8.159/src' ];
			baseline: 'Beacon' with: [
				spec repository: 'github://feenkcom/pharo-beacon:7c2cc6ba425a710274d0ca9578cac41aea84e9fb/repository' ];
			baseline: 'SpartaSkia' with: [
				spec repository: 'github://feenkcom/Sparta:v0.8.38/src' ];
			baseline: 'TaskIt' with: [
				spec repository: 'github://feenkcom/taskit:0fd525d403c488084622c1c69ef3976be0c79f05' ];
			baseline: 'GToolkitExamplesEngine' with: [
				spec repository: 'github://feenkcom/gtoolkit-examples:v0.8.16/src' ].
		spec 
			package: #'Bloc-Text-Examples' with: [
				spec requires: #('Bloc' ). ];
			package: #'Bloc-Layout-Examples' with: [
				spec requires: #('Bloc' 'GToolkitExamplesEngine' ). ];
			package: #'Bloc-Examples' with: [
				spec requires: #('Bloc' ). ];
			package: #'Bloc-Compositor-Examples' with: [
				spec requires: #('Bloc' #'Bloc-Examples' ). ]. ].

]
