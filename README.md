# DigitalBank_TestApp

## This repo is about use digitalbank for secure-build test. 

To simulator a user scenario better, we use the secure-built mongo db as a database of the Digital Banking application.
And successfully secure build the [Innovate Digital Banking](https://github.com/IBM/innovate-digital-bank) as well. 

When run the test, set the `MONGO_URL`(mongodb connection string) as the **build arguments** in the Digital Banking secure build yaml file.

And Notice that **the mongodb should setup and can be access before the Digital Banking start**.

There are the securebuild configuration samples:

- The yaml build template:

```
networktemplates:
- driver: macvlan
  gateway: 10.20.4.1
  name: enc4500_network
  parent: enc4500
  subnet: 10.20.4.0/22
- driver: bridge
  name: internal_network
quotagrouptemplates:
- filesystem: ext4
  name: p-small
  passthrough: true
  size: 30GB
- filesystem: ext4
  name: p-medium
  passthrough: true
  size: 50GB
- filesystem: btrfs
  name: np-small
  size: 30GB
- filesystem: xfs
  name: np-medium
  size: 50GB
resourcedefinitiontemplates:
- cpu: 1
  memory: 2048
  name: default
- cpu: 2
  memory: 4096
  name: small
type: virtualserver-template
version: v1

```

- The securebuild yaml of mongodb:

```
secure_build_workers:
  docker:
    base_server: hpvsop_reg
    content_trust_base: 'True'
    image_tag_prefix: latest
    pull_server: hpvsop_reg
    push_server: hpvsop_reg
    repo: hpvsop/auto_mongo
  env:
    whitelist:
    - LOGTARGET
    - ROOTFS_LOCK
    - RUNQ_ROOTDISK
  github:
    branch: mongo_sbs
    dockerfile_path: ./Dockerfile
    recurse_submodules: 'False'
    ssh_private_key_path: /root/.ssh/hpvsop_id_rsa
    url: git@github.ibm.com:ZaaS/SolutionTest_HPVSonPrem_TestApp.git
  manifest_cos:
    api_key: < optional, replace with the apikey >
    auth_endpoint: < optional, replace with the auth_endpoint >
    bucket_name: < optional, replace with the bucket_name >
    endpoint: < optional, replace with the endpoint >
    resource_crn: < optional, replace with the resource_crn >
  regfile:
    id: mongo_repo
  sbs:
    cert_path: /root/hpvs/config/securebuild/keys/sbs_mongo_cert
    key_path: /root/hpvs/config/securebuild/keys/sbs_mongo_key
    port: '443'
    url: https://10.20.4.6
  signing_key:
    private_key_path: /root/hpvs/config/isv_mongo_sb.private
    public_key_path: /root/hpvs/config/isv_mongo_sb.pub
```
- The secure build yaml of Digital Banking:

**Make sure to set the build-args `MONGO_URL` so that the Digital Banking app can talk to the mongo db.**

```
secure_build_workers:
  build:
    args:
      MONGO_URL: <the url should be replaced with the mongodb connection string. -- eg. mongodb://9.30.238.161:27017/test>
  docker:
    base_server: solutiontest_reg
    content_trust_base: 'True'
    image_tag_prefix: latest
    pull_server: solutiontest_reg
    push_server: solutiontest_reg
    repo: solutiontest/auto_dbank
  env:
    whitelist:
    - LOGTARGET
    - ROOTFS_LOCK
    - RUNQ_ROOTDISK
  github:
    branch: digitalbank_sbs
    dockerfile_path: ./Dockerfile_with_ARG
    recurse_submodules: 'False'
    ssh_private_key_path: /root/.ssh/hpvsop_id_rsa
    url: git@github.ibm.com:ZaaS/SolutionTest_HPVSonPrem_TestApp.git
  manifest_cos:
    api_key: < optional, replace with the apikey >
    auth_endpoint: < optional, replace with the auth_endpoint >
    bucket_name: < optional, replace with the bucket_name >
    endpoint: < optional, replace with the endpoint >
    resource_crn: < optional, replace with the resource_crn >
  regfile:
    id: digitalbank_repo
  sbs:
    cert_path: /root/hpvs/config/securebuild/keys/sbs_digitalbank_cert
    key_path: /root/hpvs/config/securebuild/keys/sbs_digitalbank_key
    port: '443'
    url: https://10.20.4.6
  signing_key:
    private_key_path: /root/hpvs/config/isv_digitalbank_sb.private
    public_key_path: /root/hpvs/config/isv_digitalbank_sb.pub
```

- The virtual server instance creation yaml:

```
type: virtualserver
version: v1
virtualservers:
- environment:
  - key: LOGTARGET
    value: /dev/console
  - key: ROOTFS_LOCK
    value: y
  - key: RUNQ_ROOTDISK
    value: new_qg_mongo
  host: tivlp66
  hostname: mongocontainer
  imagetag: latest
  name: hpvs_mongo
  networks:
  - ipaddress: 10.20.4.6
    ref: enc4500_network
  repoid: mongo_repo
  reporegfile: /root/hpvs/encryptedRegfile_0.enc
  resourcedefinition:
    ref: default
  volumes:
  - mounts:
    - filesystem: ext4
      mount_id: new_qg_mongo
      mountpoint: /newroot
      size: 10GB
    - filesystem: ext4
      mount_id: data
      mountpoint: /data
      size: 10GB
    name: qg_hpvs_mongo
    ref: np-small
- environment:
  - key: LOGTARGET
    value: /dev/console
  - key: ROOTFS_LOCK
    value: y
  - key: RUNQ_ROOTDISK
    value: new_qg_digitalbank
  host: tivlp66
  hostname: digitalbankcontainer
  imagetag: latest
  name: hpvs_digitalbank
  networks:
  - ipaddress: 10.20.4.7
    ref: enc4500_network
  repoid: digitalbank_repo
  reporegfile: /root/hpvs/encryptedRegfile_1.enc
  resourcedefinition:
    ref: default
  volumes:
  - mounts:
    - filesystem: ext4
      mount_id: new_qg_digitalbank
      mountpoint: /newroot
      size: 10GB
    - filesystem: ext4
      mount_id: data
      mountpoint: /data
      size: 10GB
    name: qg_hpvs_digitablbank
    ref: np-small
```
