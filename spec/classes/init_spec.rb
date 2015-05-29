require 'spec_helper'

describe 'named' do

  describe 'packages' do

    context 'defaults on osfamily RedHat with ::operatingsystemmajrelease = 7' do
      let :facts do
        {
          :kernel                     => 'Linux',
          :operatingsystem            => 'RedHat',
          :operatingsystemmajrelease  => '7',
        }
      end

      it { should contain_package('bind').with({'ensure' => 'installed'}) }
      it { should contain_package('bind-utils').with({'ensure' => 'installed'}) }
      it { should contain_package('bind-license').with({'ensure' => 'installed'}) }
      it { should contain_package('bind-libs').with({'ensure' => 'installed'}) }
      it { should contain_package('bind-libs-lite').with({'ensure' => 'installed'}) }
      it { should contain_package('bind-chroot').with({'ensure' => 'absent'}) }
    end

    context 'defaults on osfamily RedHat with ::operatingsystemmajrelease = 7 and chroot' do
      let :facts do
        {
          :kernel                     => 'Linux',
          :operatingsystem            => 'RedHat',
          :operatingsystemmajrelease  => '7',
        }
      end
      let :params do
        {
          :chroot                     => true,
        }
      end

      it { should contain_package('bind').with({'ensure' => 'installed'}) }
      it { should contain_package('bind-utils').with({'ensure' => 'installed'}) }
      it { should contain_package('bind-license').with({'ensure' => 'installed'}) }
      it { should contain_package('bind-libs').with({'ensure' => 'installed'}) }
      it { should contain_package('bind-libs-lite').with({'ensure' => 'installed'}) }
      it { should contain_package('bind-chroot').with({'ensure' => 'installed'}) }
    end

  end

  describe 'services' do

    context 'defaults on osfamily RedHat with ::operatingsystemmajrelease = 7' do
      let :facts do
        {
          :kernel                     => 'Linux',
          :operatingsystem            => 'RedHat',
          :operatingsystemmajrelease  => '7',
        }
      end

      it { should contain_service('named').with({'ensure' => 'running'}) }
    end

    context 'defaults on osfamily RedHat with ::operatingsystemmajrelease = 7 and chroot' do
      let :facts do
        {
          :kernel                     => 'Linux',
          :operatingsystem            => 'RedHat',
          :operatingsystemmajrelease  => '7',
        }
      end
      let :params do
        {
          :chroot                     => true,
        }
      end

      it { should contain_service('named-chroot').with({'ensure' => 'running'}) }
      it { should contain_service('named').with({'ensure' => 'stopped'}) }
    end

  end

end
