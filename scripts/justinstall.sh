#!/bin/sh -ex
ALTISCALE_RELEASE=${ALTISCALE_RELEASE:-0.1.0}
export RPM_NAME=`echo vcc-sqoop-${ARTIFACT_VERSION}`
echo "Packaging sqoop rpm with name ${RPM_NAME} with version ${ALTISCALE_RELEASE}-${DATE_STRING}"

export RPM_BUILD_DIR=${INSTALL_DIR}/opt
mkdir --mode=0755 -p ${RPM_BUILD_DIR}

export RPM_CONFIG_DIR=${INSTALL_DIR}/etc/sqoop-${ARTIFACT_VERSION}
mkdir --mode=0755 -p ${RPM_CONFIG_DIR}

cd ${RPM_BUILD_DIR}
tar -xvzpf ${WORKSPACE}/sqoop/build/sqoop-${ARTIFACT_VERSION}.tar.gz
ln -s sqoop-${ARTIFACT_VERSION} sqoop
mv sqoop/conf/* ${RPM_CONFIG_DIR}
rm -rf sqoop/conf
ln -s /etc/sqoop-${ARTIFACT_VERSION} sqoop/conf 

cd ${RPM_CONFIG_DIR}
cd ..
ln -s sqoop-${ARTIFACT_VERSION} sqoop

cd ${RPM_DIR}
fpm --verbose \
--maintainer ops@verticloud.com \
--vendor VertiCloud \
--provides ${RPM_NAME} \
--description "${DESCRIPTION}" \
--replaces vcc-sqoop-${ARTIFACT_VERSION} \
-s dir \
-t rpm \
-n ${RPM_NAME} \
-v ${ALTISCALE_RELEASE} \
--iteration ${DATE_STRING} \
--rpm-user root \
--rpm-group root \
-C ${INSTALL_DIR} \
opt etc
