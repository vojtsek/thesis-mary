MARY_VERSION=5.3-SNAPSHOT
MARY_BASE=/mary/marytts
VOICE_TOOLS=$(MARY_BASE)/target/marytts-builder-$(MARY_VERSION)/bin/voiceimport.sh
MARY_SERVER=$(MARY_BASE)/target/marytts-$(MARY_VERSION)/bin/marytts-server
ROOT_DIR=/mary/marytts-voice-building

all: AllophonesExtractor EHMMlabeler LabelPauseDeleter PhoneUnitLabelComputer TranscriptionAligner mary/features.txt PhoneUnitFeatureComputer PhoneLabelFeatureAligner HMMVoiceDataPreparation mary/hmmFeatures.txt HMMVoiceConfigure HMMVoiceMakeData HMMVoiceMakeVoice HMMVoiceCompiler

clean:
	rm -rf allophones ehmm/feat ehmm/lab lab phonefeatures phonelab prompt_allophones 
	cd $(ROOT_DIR)/hts && make clean
	cd $(ROOT_DIR)/hts/data && rm -rf raw str labels/gen questions
AllophonesExtractor: text/ wav/
	$(VOICE_TOOLS) AllophonesExtractor

EHMMlabeler: prompt_allophones/
	$(VOICE_TOOLS) EHMMLabeler

LabelPauseDeleter: ehmm/lab/
	$(VOICE_TOOLS) LabelPauseDeleter

PhoneUnitLabelComputer: lab/
	$(VOICE_TOOLS) PhoneUnitLabelComputer

TranscriptionAligner: phonelab/
	$(VOICE_TOOLS) TranscriptionAligner

FeatureSelection: allophones/
	$(VOICE_TOOLS) FeatureSelection

PhoneUnitFeatureComputer: mary/features.txt
	$(VOICE_TOOLS) PhoneUnitFeatureComputer

PhoneLabelFeatureAligner: phonelab/ phonefeatures/
	$(VOICE_TOOLS) PhoneLabelFeatureAligner

HMMVoiceDataPreparation: phonefeatures/ phonelab/ $(ROOT_DIR)/mary/features.txt $(MARY_BASE)/lib/external/externalBinaries.config
	$(VOICE_TOOLS) HMMVoiceDataPreparation

HMMVoiceConfigure:
	$(VOICE_TOOLS) HMMVoiceConfigure
HMMVoiceFeatureSelection: $(ROOT_DIR)/mary/features.txt
	$(VOICE_TOOLS) HMMVoiceFeatureSelection

HMMVoiceMakeData: $(ROOT_DIR)/mary/hmmFeatures.txt $(ROOT_DIR)/hts/data/
	$(VOICE_TOOLS) HMMVoiceMakeData
	# make mgc lf0 str-mary cmp-mary list scp

HMMVoiceMakeVoice: $(ROOT_DIR)/hts/data
	cd $(ROOT_DIR)/hts
	perl $(ROOT_DIR)/hts/scripts/Training.pl $(ROOT_DIR)/hts/scripts/Config.pm > make-voice.log

HMMVoiceCompiler: $(ROOT_DIR)/hts/data/
	$(VOICE_TOOLS) HMMVoiceCompiler

HTS: hts/
	cd hts/ && chmod +x configure
	./configure --with-sptk-search-path=/mary/marytts/lib/external/bin/ --with-hts-search-path=/mary/marytts/lib/external/bin/ --with-hts-engine-search-path=/mary/marytts/lib/external/bin/
