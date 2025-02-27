/// <reference path="./matchers/beWithin.ts"/>

import { PegasysFixtureType } from './shared/fixtures'

export type TestContext = PegasysFixtureType & {
  subject?: Function
}
