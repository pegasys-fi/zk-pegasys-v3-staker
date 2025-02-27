import { PegasysV3Staker } from '../../typechain'
import { pegasysFixture, PegasysFixtureType } from '../shared/fixtures'
import { expect } from '../shared'
import { provider } from '../shared/provider'
import { deployContract, getWallets } from '../shared/zkSyncUtils'

describe('unit/Deployment', () => {
  let context: PegasysFixtureType

  beforeEach('create fixture loader', async () => {
    context = await pegasysFixture(getWallets(), provider)
  })

  it('deploys and has an address', async () => {
    const staker = (await deployContract(getWallets()[0], 'PegasysV3Staker', [
      context.factory.address,
      context.nft.address,
      2 ** 32,
      2 ** 32,
    ])) as PegasysV3Staker
    expect(staker.address).to.be.a.string
  })

  it('sets immutable variables', async () => {
    const staker = (await deployContract(getWallets()[0], 'PegasysV3Staker', [
      context.factory.address,
      context.nft.address,
      2 ** 32,
      2 ** 32,
    ])) as PegasysV3Staker

    expect(await staker.factory()).to.equal(context.factory.address)
    expect(await staker.nonfungiblePositionManager()).to.equal(context.nft.address)
    expect(await staker.maxIncentiveDuration()).to.equal(2 ** 32)
    expect(await staker.maxIncentiveStartLeadTime()).to.equal(2 ** 32)
  })
})
