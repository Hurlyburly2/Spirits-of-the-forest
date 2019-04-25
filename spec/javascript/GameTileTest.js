import GameTile from '../../app/javascript/react/components/GameTile'

describe('GameTile', () => {
  let wrapper,
    id,
    opponent;
    
  beforeEach(() => {
    wrapper = mount(
      <GameTile
        id="1"
        opponent="Waiting for Opponent"
      />
    )
  })
  
  it('should render a link', () => {
    expect(wrapper.find('a')).toBePresent();
  })
  
  it('should render a link with the correct text', () => {
    expect(wrapper.find('a').text()).toBe('Game #1Waiting for Opponent')
  })
})
