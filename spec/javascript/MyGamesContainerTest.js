import fetchMock from "fetch-mock";
import './testHelper.js'

import MyGamesContainer from '../../app/javascript/react/containers/MyGamesContainer'
import GameTile from '../../app/javascript/react/components/GameTile'


describe('MyGamesContainer', () => {
  let wrapper, data, currentUser;

  beforeEach(() => {
    data = {
      currentUser: {
        email: "email@email.com",
        id: 3,
        username: "SIGNED IN USER"
      },
      games: [
        {
          id: 1,
          users: [
            {
              id: 3,
              username: "SIGNED IN USER"
            }
          ]
        }
      ]
    }

    fetchMock.get('/api/v1/games', {
      status: 200,
      body: data
    })

    wrapper = mount(
      <MyGamesContainer/>
    )
  })

  it('should render a Game Tile component', (done) => {
    setTimeout(() => {
      console.log(wrapper.debug())
      expect(wrapper.find(GameTile)).toBePresent();
      done()
    }, 0)
  })

  it('should render a Game Tile component with the proper props', (done) => {
    setTimeout(() => {
      expect(wrapper.find(GameTile).props().id).toEqual(1)
      expect(wrapper.find(GameTile).props().opponent).toEqual("Waiting for Opponent")
      done()
    }, 0)
  })
})
